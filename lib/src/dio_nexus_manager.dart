import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_nexus/dio_nexus.dart';
import 'package:dio_nexus/src/network/nexus_language.dart';
import 'package:dio_nexus/src/utility/custom_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retry/retry.dart';

part 'network/network_interceptor.dart';
part 'network/network_model_parser.dart';

/// The DioNexusManager class is a Dart class that extends the DioMixin class and implements the Dio and
/// IDioNexusManager interfaces.
class DioNexusManager with DioMixin implements Dio, IDioNexusManager {
  // ignore: public_member_api_docs
  DioNexusManager({
    required BaseOptions options,
    Interceptor? interceptor,
    this.onRefreshToken,
    this.onRefreshFail,
    this.networkConnection,
    this.timeoutToast,
    this.printLogsDebugMode = false,
    this.maxNetworkTryCount = 5,
    this.locale,
  }) : assert(
          options.headers.containsKey(Headers.contentTypeHeader),
          'Content-Type header is required',
        ) {
    this.options = options;
    (transformer as BackgroundTransformer).jsonDecodeCallback = parseJson;

    _addLogInterceptor();
    networkInterceptor(interceptor);
    NexusLanguage.languageLoad(locale);
    httpClientAdapter = HttpClientAdapter();
  }

  /// For example, `const Locale('tr')` and `const Locale('en')` are equal and
  /// both have the [languageCode] `tr`, because `en` is a deprecated language
  /// subtag that was replaced by the subtag `tr`.
  @override
  Locale? locale;
 
  /// [onRefrestToken] when HttpStatus return unauthorized, you can call your refrestToken manager
  @override
  Future<DioException> Function(DioException error, BaseOptions options)? onRefreshToken;

  /// If [onRefrestToken] return fail, this metot will work.
  ///
  /// Example: When refreshToken==fail, app will logout.
  @override
  Function? onRefreshFail;

  /// When statusCode == HttpStatus.unauthorized, if you have provided a refresh token, the token renewal process starts.
  ///
  /// During this process, the retry function runs, enabling multiple attempts. You can manually set the number of attempts by adjusting the value of [maxAttempts].
  @override
  final int maxAttempts = 3;

  /// Set true to print requests or errors received.
  @override
  final bool? printLogsDebugMode;

  /// When no internet connection, request again to server
  @override
  NetworkConnection? networkConnection;

  /// Show toast when request or connection timeout.
  /// Default value is false.
  @override
  TimeoutToast? timeoutToast;

  /// This variable is used for no internet connection.
  /// You can modify this counter when initializing [DioNexusManager].
  /// When your internet connection is lost, you can try re-requesting up to 5 times.
  @override
  int maxNetworkTryCount;

  /// The line `int networkTryCounter = 0;` is declaring and initializing a variable named
  /// `networkTryCounter` of type `int` with an initial value of `0`. This variable is used to keep
  /// track of the number of times a network request has been attempted. It is incremented each time a
  /// network request is made and can be used to limit the number of retry attempts or for other
  /// purposes related to network request handling.
  int networkTryCounter = 0;

  /// Get all interceptors
  @override
  Interceptors get showInterceptors => interceptors;

  @override
  Future<IResponseModel<R?>?>
      sendRequest<T extends IDioNexusNetworkModel<T>, R>(
    String path, {
    required T responseModel,
    required RequestType requestType,
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    options ??= Options();
    options.method = requestType.name;

    try {
      final response = await request(
        path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: options,
        onSendProgress: onSendProgress,
      );
      var _response = response.data;
      if (_response is String && R is! NexusModel) {
        _response = await parseJson(_response);
      }
      final result = _modelResponseData<T, R>(
        responseModel,
        _response,
        printLogsDebugMode,
      );

      return ResponseModel<R?>(result, null);
    } on DioException catch (err) {
      return handleNetworkError<T, R>(
        err,
        path,
        data: data,
        responseModel: responseModel,
        requestType: requestType,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    }
  }

  void _addLogInterceptor() {
    if (printLogsDebugMode ?? false) interceptors.add(LogInterceptor());
  }

  @override
  void addBaseHeader(MapEntry<String, String> mapEntry) {
    options.headers[mapEntry.key] = mapEntry.value;
  }

  @override
  void clearAllHeaders() {
    options.headers.clear();
  }

  @override
  void removeHeader(String key) {
    options.headers.remove(key);
  }

  @override
  Map<String, dynamic> get getAllHeaders => options.headers;
}
