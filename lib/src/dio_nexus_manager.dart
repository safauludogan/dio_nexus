import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_nexus/src/utility/custom_logger.dart';
import 'interface/index.dart';
import 'utility/enum/request_type.dart';
import 'package:flutter/foundation.dart';
import 'model/response_model.dart';
import 'network/network_error.dart';
import 'network/network_interceptor.dart';
import 'utility/network_connectivity/network_connection.dart';
part 'network/network_model_parser.dart';

class DioNexusManager with DioMixin implements Dio, IDioNexusManager {
  DioNexusManager(
      {required BaseOptions options,
      Interceptor? interceptor,
      this.onRefreshToken,
      this.networkConnection,
      this.printLogsDebugMode = false,
      this.maxNetworkTryCount = 5})
      : assert(options.headers.containsKey(Headers.contentTypeHeader),
            'Content-Type header is required') {
    this.options = options;
    (transformer as BackgroundTransformer).jsonDecodeCallback = parseJson;
    httpClientAdapter = HttpClientAdapter();

    interceptors.add(networkInterceptor());
    _addLogInterceptor();
  }

  /// [onRefrestToken] when HttpStatus return unauthorized, you can call your refrestToken manager
  Future Function(DioError error)? onRefreshToken;

  /// [maxAttempts] When catch error(unauthorized or TieoutExc. etc.) try 3 request to server
  final int maxAttempts = 3;

  final bool? printLogsDebugMode;

  /// When no internet connection, request again to server
  NetworkConnection? networkConnection;

  /// This variable is used for no internet connection.
  /// You can modify this counter when initializing [DioNexusManager].
  /// When your internet connection is lost, you can try re-requesting up to 5 times.
  int maxNetworkTryCount;

  int networkTryCounter = 0;

  @override
  Future<IResponseModel<R?>?>
      sendRequest<T extends IDioNexusNetworkModel<T>, R>(
    String path, {
    Object? data,
    required T responseModel,
    required RequestType requestType,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    options ??= Options();
    options.method = requestType.name;
    try {
      var response = await request(path,
          data: data,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          options: options,
          onSendProgress: onSendProgress);
      var _response = response.data;
      if (response.data is String) {
        _response = await parseJson(response.data);
      }
      var result = _modelResponseData<T, R>(responseModel, _response);
      return ResponseModel<R?>(result, null);
    } on DioError catch (err) {
      return handleNetworkError<T, R>(err, path,
          data: data,
          responseModel: responseModel,
          requestType: requestType,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          options: options,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
    }
  }

  void _addLogInterceptor() {
    if (printLogsDebugMode ?? false) interceptors.add(LogInterceptor());
  }
}
