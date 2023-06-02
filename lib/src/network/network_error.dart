import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
import '../../dio_nexus.dart';

extension DioNexusManagerExtension on DioNexusManager {
  Future<IResponseModel<R?>>
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
        await networkConnection!.checkConnection(() async {
          await sendRequest(
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
        });
      }
    }
    return ResponseModel<R?>(
        null, error.response?.statusCode, error.error.toString());
  }
}
