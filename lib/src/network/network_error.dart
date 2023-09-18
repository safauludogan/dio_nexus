import 'dart:async';
import 'package:dio_nexus/dio_nexus.dart';

/// The `extension DioNexusManagerExtension on DioNexusManager` is creating an extension on the
/// `DioNexusManager` class. This allows you to add new functionality or methods to the
/// `DioNexusManager` class without modifying its original implementation.
extension DioNexusManagerExtension on DioNexusManager {
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
    if (networkConnection != null) {
      var _timeOut = false;
      var _retry = false;
      final connectionResult = await networkConnection!.checkInternetConnection(
        (timeOut) {
          _timeOut = timeOut;
        },
        (retry) {
          _retry = retry;
        },
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
        return sendRequest(
          path,
          requestType: requestType,
          responseModel: responseModel,
          cancelToken: cancelToken,
          data: data,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onReceiveProgress,
          options: options,
          queryParameters: queryParameters,
        );
      }
    }
    final dioException =
        NetworkExceptions.getDioException(error, printLogsDebugMode);
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
