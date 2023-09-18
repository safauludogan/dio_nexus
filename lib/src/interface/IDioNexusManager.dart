import 'package:flutter/material.dart';
import '../../dio_nexus.dart';

abstract class IDioNexusManager {
  IDioNexusManager(
      {required BaseOptions options,
      Interceptor? interceptor,
      this.onRefreshToken,
      this.networkConnection,
      this.maxAttempts = 3,
      this.printLogsDebugMode = false,
      this.maxNetworkTryCount = 5});

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
  });

  Future<DioException> Function(DioException error, BaseOptions options)? onRefreshToken;
  Function? onRefreshFail;
  final int? maxAttempts;
  final bool? printLogsDebugMode;
  NetworkConnection? networkConnection;
  TimeoutToast? timeoutToast;
  int maxNetworkTryCount;
  void addBaseHeader(MapEntry<String, String> key);
  void clearAllHeaders();
  void removeHeader(String key);
  Map<String, dynamic> get getAllHeaders;
  Interceptors get showInterceptors;
  Locale? locale;
}
