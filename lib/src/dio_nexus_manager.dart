import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_nexus/src/utility/custom_logger.dart';
import 'interface/index.dart';
import 'model/enum/request_type.dart';
import 'package:flutter/foundation.dart';
import 'model/enum/response_model.dart';
import 'network/network_error.dart';
part 'network/network_model_parser.dart';

class DioNexusManager with DioMixin implements Dio, IDioNexusManager {
  DioNexusManager({
    required BaseOptions options,
    this.onRefreshToken,
  }) {
    this.options = options;
    (transformer as BackgroundTransformer).jsonDecodeCallback = parseJson;
    httpClientAdapter = HttpClientAdapter();
    this.options.connectTimeout = const Duration(seconds: 2);
  }

  /// [onRefrestToken] when HttpStatus return unauthorized, you can call your refrestToken manager
  Future Function()? onRefreshToken;

  /// [maxAttempts] When catch error(unauthorized or TieoutExc. etc.) try 3 request to server
  final int maxAttempts = 3;

  @override
  Future<IResponseModel<R?>> sendRequest<T extends IDioNexusNetworkModel<T>, R>(
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
        var _response = await parseJson(response.data);
      }
      var result = _modelResponseData<T, R>(responseModel, _response);
      return ResponseModel<R?>(result, response.statusCode!, null);
    } on DioError catch (err) {
      print(err);

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
}
