import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_nexus/src/network/index.dart';
import 'package:dio_nexus/src/utility/index.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

/// Enum representing different types of network errors
enum NetworkErrorType {
  /// The request cancelled exception.
  requestCancelled,

  /// The unauthorized request exception.
  unauthorizedRequest,

  /// The bad request exception.
  badRequest,

  /// The not found exception.
  notFound,

  /// The method not allowed exception.
  methodNotAllowed,

  /// The not acceptable exception.
  notAcceptable,

  /// The request timeout exception.
  requestTimeout,

  /// The send timeout exception.
  sendTimeout,

  /// The receive timeout exception.
  receiveTimeout,

  /// The connection error exception.
  connectionError,

  /// The conflict exception.
  conflict,

  /// The forbidden request exception.
  forbiddenRequest,

  /// The internal server error exception.
  internalServerError,

  /// The bad certificate exception.
  badCertificate,

  /// The not implemented exception.
  notImplemented,

  /// The service unavailable exception.
  serviceUnavailable,

  /// The no internet connection exception.
  noInternetConnection,

  /// The format exception.
  formatException,

  /// The unable to process exception.
  unableToProcess,

  /// The default error exception.
  defaultError,

  /// The unexpected error exception.
  unexpectedError,

  /// The rate limit exceeded exception.
  rateLimitExceeded,

  /// The bad gateway exception.
  badGateway,

  /// The gateway timeout exception.
  gatewayTimeout,
}

/// Extension to get localized error messages for each error type
extension NetworkErrorTypeX on NetworkErrorType {
  /// Get the error message for the given error type
  String getErrorMessage([String? reason]) {
    switch (this) {
      case NetworkErrorType.notImplemented:
        return NexusLanguage.getLang.notImplemented;
      case NetworkErrorType.requestCancelled:
        return NexusLanguage.getLang.requestCancelled;
      case NetworkErrorType.internalServerError:
        return NexusLanguage.getLang.internalServerError;
      case NetworkErrorType.notFound:
        return reason ?? NexusLanguage.getLang.notFound;
      case NetworkErrorType.serviceUnavailable:
        return NexusLanguage.getLang.serviceUnavailable;
      case NetworkErrorType.methodNotAllowed:
        return NexusLanguage.getLang.methodNotAllowed;
      case NetworkErrorType.badRequest:
        return reason ?? NexusLanguage.getLang.badRequest;
      case NetworkErrorType.unauthorizedRequest:
        return reason ?? NexusLanguage.getLang.unauthorizedRequest;
      case NetworkErrorType.unexpectedError:
        return NexusLanguage.getLang.unexpectedError;
      case NetworkErrorType.requestTimeout:
        return NexusLanguage.getLang.requestTimeout;
      case NetworkErrorType.noInternetConnection:
        return NexusLanguage.getLang.networkConnectionNoInternetConnection;
      case NetworkErrorType.conflict:
        return NexusLanguage.getLang.conflict;
      case NetworkErrorType.sendTimeout:
        return NexusLanguage.getLang.sendTimeout;
      case NetworkErrorType.unableToProcess:
        return NexusLanguage.getLang.unableToProcess;
      case NetworkErrorType.formatException:
        return NexusLanguage.getLang.formatException;
      case NetworkErrorType.notAcceptable:
        return NexusLanguage.getLang.notAcceptable;
      case NetworkErrorType.badCertificate:
        return reason ?? NexusLanguage.getLang.badCertificate;
      case NetworkErrorType.connectionError:
        return NexusLanguage.getLang.connectionError;
      case NetworkErrorType.receiveTimeout:
        return NexusLanguage.getLang.receiveTimeout;
      case NetworkErrorType.forbiddenRequest:
        return reason ?? NexusLanguage.getLang.forbiddenRequest;
      case NetworkErrorType.defaultError:
        return reason ?? NexusLanguage.getLang.unexpectedError;
      case NetworkErrorType.rateLimitExceeded:
        return NexusLanguage.getLang.rateLimitExceeded;
      case NetworkErrorType.badGateway:
        return NexusLanguage.getLang.badGateway;
      case NetworkErrorType.gatewayTimeout:
        return NexusLanguage.getLang.gatewayTimeout;
    }
  }
}

/// The NetworkExceptions class is a comprehensive implementation of network-related exceptions
/// using freezed for immutable state management.
///
/// It provides a wide range of network exception types including HTTP status codes,
/// connection errors, timeout errors, and more.
@freezed
abstract class NetworkExceptions with _$NetworkExceptions {
  /// The request cancelled exception.
  const factory NetworkExceptions.requestCancelled(String? reason) =
      RequestCancelled;

  /// The unauthorized request exception.
  const factory NetworkExceptions.unauthorizedRequest(String? reason) =
      UnauthorizedRequest;

  /// The bad request exception.
  const factory NetworkExceptions.badRequest(String? reason) = BadRequest;

  /// The not found exception.
  const factory NetworkExceptions.notFound(String? reason) = NotFound;

  /// The method not allowed exception.
  const factory NetworkExceptions.methodNotAllowed(String? reason) =
      MethodNotAllowed;

  /// The not acceptable exception.
  const factory NetworkExceptions.notAcceptable(String? reason) = NotAcceptable;

  /// The request timeout exception.
  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  /// The send timeout exception.
  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  /// The receive timeout exception.
  const factory NetworkExceptions.receiveTimeout() = ReceiveTimeout;

  /// The connection error exception.
  const factory NetworkExceptions.connectionError(String? reason) =
      ConnectionError;

  /// The conflict exception.
  const factory NetworkExceptions.conflict(String? reason) = Conflict;

  /// The forbidden request exception.
  const factory NetworkExceptions.forbiddenRequest(String? reason) =
      ForbiddenRequest;

  /// The internal server error exception.
  const factory NetworkExceptions.internalServerError(String? reason) =
      InternalServerError;

  /// The bad certificate exception.
  const factory NetworkExceptions.badCertificate(String? reason) =
      BadCertificate;

  /// The not implemented exception.
  const factory NetworkExceptions.notImplemented(String? reason) =
      NotImplemented;

  /// The service unavailable exception.
  const factory NetworkExceptions.serviceUnavailable(String? reason) =
      ServiceUnavailable;

  /// The no internet connection exception.
  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  /// The format exception.
  const factory NetworkExceptions.formatException() = FormatException;

  /// The unable to process exception.
  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  /// The default error exception.
  const factory NetworkExceptions.defaultError({required String error}) =
      DefaultError;

  /// The unexpected error exception.
  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  /// The rate limit exceeded exception.
  const factory NetworkExceptions.rateLimitExceeded() = RateLimitExceeded;

  /// The bad gateway exception.
  const factory NetworkExceptions.badGateway() = BadGateway;

  /// The gateway timeout exception.
  const factory NetworkExceptions.gatewayTimeout() = GatewayTimeout;

  /// Creates a NetworkException from a Dio error or other error types
  ///
  /// Args:
  ///   error (dynamic): The error to be mapped
  ///   printLogsDebugMode (bool?): Whether to print debug logs
  factory NetworkExceptions.fromError(
    dynamic error, {
    bool? printLogsDebugMode,
  }) {
    CustomLogger(data: error.toString())
        .show(printLog: printLogsDebugMode ?? false);

    if (error is Exception) {
      try {
        if (error is DioException) {
          return _handleDioException(error);
        } else if (error is SocketException) {
          return const NetworkExceptions.noInternetConnection();
        }
        return const NetworkExceptions.unexpectedError();
      } on FormatException {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return const NetworkExceptions.unableToProcess();
      }
      return const NetworkExceptions.unexpectedError();
    }
  }

  /// Helper method to handle DioException specific cases
  static NetworkExceptions _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return NetworkExceptions.requestCancelled(
          error.response?.data.toString(),
        );
      case DioExceptionType.connectionTimeout:
        return const NetworkExceptions.requestTimeout();
      case DioExceptionType.unknown:
        return NetworkExceptions.defaultError(
          error: error.response?.data.toString() ?? error.error.toString(),
        );
      case DioExceptionType.receiveTimeout:
        return const NetworkExceptions.receiveTimeout();
      case DioExceptionType.badResponse:
        return _handleBadResponse(error);
      case DioExceptionType.sendTimeout:
        return const NetworkExceptions.sendTimeout();
      case DioExceptionType.badCertificate:
        return NetworkExceptions.badCertificate(
          error.response?.data.toString(),
        );
      case DioExceptionType.connectionError:
        return NetworkExceptions.connectionError(
          error.response?.data.toString(),
        );
    }
  }

  /// Helper method to handle bad response status codes
  static NetworkExceptions _handleBadResponse(DioException error) {
    final responseData = error.response?.data?.toString();
    final statusCode = error.response?.statusCode;

    switch (statusCode) {
      case 400:
        return NetworkExceptions.badRequest(responseData);
      case 401:
        return NetworkExceptions.unauthorizedRequest(responseData);
      case 403:
        return NetworkExceptions.forbiddenRequest(responseData);
      case 404:
        return NetworkExceptions.notFound(responseData);
      case 405:
        return NetworkExceptions.methodNotAllowed(responseData);
      case 406:
        return NetworkExceptions.notAcceptable(responseData);
      case 408:
        return const NetworkExceptions.requestTimeout();
      case 409:
        return NetworkExceptions.conflict(responseData);
      case 429:
        return const NetworkExceptions.rateLimitExceeded();
      case 500:
        return NetworkExceptions.internalServerError(responseData);
      case 502:
        return const NetworkExceptions.badGateway();
      case 503:
        return NetworkExceptions.serviceUnavailable(responseData);
      case 504:
        return const NetworkExceptions.gatewayTimeout();
      default:
        return NetworkExceptions.defaultError(
          error: 'Received invalid status code: $statusCode',
        );
    }
  }

  /// Gets a human-readable error message for the network exception
  ///
  /// Args:
  ///   networkExceptions (NetworkExceptions): The network exception to get message for
  ///
  /// Returns:
  ///   String: The localized error message
  static String getErrorMessage(NetworkExceptions networkExceptions) {
    return networkExceptions.when(
      notImplemented: (reason) =>
          NetworkErrorType.notImplemented.getErrorMessage(reason),
      requestCancelled: (reason) =>
          NetworkErrorType.requestCancelled.getErrorMessage(reason),
      internalServerError: (reason) =>
          NetworkErrorType.internalServerError.getErrorMessage(reason),
      notFound: (reason) => NetworkErrorType.notFound.getErrorMessage(reason),
      serviceUnavailable: (reason) =>
          NetworkErrorType.serviceUnavailable.getErrorMessage(reason),
      methodNotAllowed: (reason) =>
          NetworkErrorType.methodNotAllowed.getErrorMessage(reason),
      badRequest: (reason) =>
          NetworkErrorType.badRequest.getErrorMessage(reason),
      unauthorizedRequest: (reason) =>
          NetworkErrorType.unauthorizedRequest.getErrorMessage(reason),
      unexpectedError: () => NetworkErrorType.unexpectedError.getErrorMessage(),
      requestTimeout: () => NetworkErrorType.requestTimeout.getErrorMessage(),
      noInternetConnection: () =>
          NetworkErrorType.noInternetConnection.getErrorMessage(),
      conflict: (reason) => NetworkErrorType.conflict.getErrorMessage(reason),
      sendTimeout: () => NetworkErrorType.sendTimeout.getErrorMessage(),
      unableToProcess: () => NetworkErrorType.unableToProcess.getErrorMessage(),
      defaultError: (error) =>
          NetworkErrorType.defaultError.getErrorMessage(error),
      formatException: () => NetworkErrorType.formatException.getErrorMessage(),
      notAcceptable: (reason) =>
          NetworkErrorType.notAcceptable.getErrorMessage(reason),
      badCertificate: (reason) =>
          NetworkErrorType.badCertificate.getErrorMessage(reason),
      connectionError: (reason) =>
          NetworkErrorType.connectionError.getErrorMessage(reason),
      receiveTimeout: () => NetworkErrorType.receiveTimeout.getErrorMessage(),
      forbiddenRequest: (reason) =>
          NetworkErrorType.forbiddenRequest.getErrorMessage(reason),
      rateLimitExceeded: () =>
          NetworkErrorType.rateLimitExceeded.getErrorMessage(),
      badGateway: () => NetworkErrorType.badGateway.getErrorMessage(),
      gatewayTimeout: () => NetworkErrorType.gatewayTimeout.getErrorMessage(),
    );
  }
}
