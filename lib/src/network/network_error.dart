import 'dart:async';
import 'dart:io';
import 'package:retry/retry.dart';
import '../../dio_nexus.dart';

extension DioNexusManagerExtension on DioNexusManager {
  Future<IResponseModel<R?>?>
      handleNetworkError<T extends IDioNexusNetworkModel<T>, R>(
    DioError error,
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
    if (error.response?.statusCode == HttpStatus.unauthorized) {
      //Burada refreshToken'ı çalıştırmayı dene

      if (onRefreshToken != null) {
        await onRefreshToken?.call(error);
        final r = RetryOptions(maxAttempts: maxAttempts);
        await r.retry(
          // Make a GET request
          () async => await sendRequest(
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
          // Retry on SocketException or TimeoutException
          retryIf: (e) => e is SocketException || e is TimeoutException,
        );
      }
    } else {
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
                            NetworkExceptions.getDioException(
                                error, printLogsDebugMode))
                        .toString(),
                    NetworkExceptions.getDioException(
                        error, printLogsDebugMode)));
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
    }
    if (timeoutToast != null) {
      timeoutToast!
          .show(NetworkExceptions.getDioException(error, printLogsDebugMode));
    }
    NetworkExceptions dioException =
        NetworkExceptions.getDioException(error, printLogsDebugMode);
    return ResponseModel<R?>(
        null,
        ErrorModel(error.response?.statusCode,
            NetworkExceptions.getErrorMessage(dioException), dioException));
  }
}
