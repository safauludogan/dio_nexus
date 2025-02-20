import 'dart:async';
import 'package:dio_nexus/src/index.dart';
import 'package:dio_nexus/src/model/index.dart';

/// The `extension DioNexusManagerExtension on DioNexusManager` is creating an extension on the
/// `DioNexusManager` class. This allows you to add new functionality or methods to the
/// `DioNexusManager` class without modifying its original implementation.
extension DioNexusManagerExtension on DioNexusManager {
  /// Handle network error
  /// This handle error for [sendRequest]
  Future<IResponseModel<R?>?>
      handleNetworkError<T extends IDioNexusNetworkModel<T>, R>(
    DioException error,
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
    return _handleConnectionCheck(
      onRetry: () async => sendRequest(
        path,
        requestType: requestType,
        responseModel: responseModel,
        cancelToken: cancelToken,
        data: data,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onReceiveProgress,
        options: options,
        queryParameters: queryParameters,
      ),
      error: error,
    );
  }

  /// Handle network error
  /// This handle error for [sendPrimitiveRequest]
  Future<IResponseModel<R?>?> handlePrimitiveError<R>(
    DioException error,
    String path, {
    required RequestType requestType,
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return _handleConnectionCheck(
      onRetry: () async => sendPrimitiveRequest(
        path,
        requestType: requestType,
        cancelToken: cancelToken,
        data: data,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
        options: options,
        queryParameters: queryParameters,
      ),
      error: error,
    );
  }

  /// Handle connection check
  Future<IResponseModel<R?>?> _handleConnectionCheck<R>({
    required Future<IResponseModel<R?>?> Function() onRetry,
    required DioException error,
  }) async {
    if (networkConnection != null) {
      /// [timeOut] is a variable that is used to check if the timeout is reached.
      var _timeOut = false;

      /// [retry] is a variable that is used to check if the retry is reached.
      var _retry = false;

      /// [connectionResult] is a variable that is used to check if the connection is successful.
      final connectionResult = await networkConnection!.checkInternetConnection(
        (timeOut) => _timeOut = timeOut,
        (retry) => _retry = retry,
      );
      if (!connectionResult || _retry) {
        networkTryCounter++;
        if ((networkTryCounter >= maxNetworkTryCount && !connectionResult) ||
            _timeOut) {
          networkTryCounter = 0;

          return ResponseModel<R?>(
            null,
            ErrorModel(
              error.response?.statusCode,
              NetworkExceptions.getErrorMessage(
                const NetworkExceptions.noInternetConnection(),
              ),
              const NetworkExceptions.noInternetConnection(),
            ),
          );
        }
        return onRetry.call();
      }
    }
    final dioException = NetworkExceptions.fromError(
      error,
      printLogsDebugMode: printLogsDebugMode,
    );
    if (timeoutToast != null) timeoutToast!.show(dioException);
    return ResponseModel<R?>(
      null,
      ErrorModel(
        error.response?.statusCode,
        NetworkExceptions.getErrorMessage(dioException),
        dioException,
      ),
    );
  }
}
