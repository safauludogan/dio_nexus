import 'dart:async';
import '../../dio_nexus.dart';

extension DioNexusManagerExtension on DioNexusManager {
  Future<IResponseModel<R?>?>
      handleNetworkError<T extends IDioNexusNetworkModel<T>, R>(
    DioException error,
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
    if (networkConnection != null) {
      bool _timeOut = false;
      bool _retry = false;
      var connectionResult = await networkConnection!.checkInternetConnection(
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
                          const NetworkExceptions.noInternetConnection())
                      .toString(),
                  const NetworkExceptions.noInternetConnection()));
        }
        return await sendRequest(
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
    NetworkExceptions dioException =
        NetworkExceptions.getDioException(error, printLogsDebugMode);
    if (timeoutToast != null) timeoutToast!.show(dioException);
    return ResponseModel<R?>(
        null,
        ErrorModel(error.response?.statusCode,
            NetworkExceptions.getErrorMessage(dioException), dioException));
  }
}
