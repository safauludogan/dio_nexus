import 'dart:io';
import 'package:dio_nexus/dio_nexus.dart';
import 'package:dio_nexus/src/network/nexus_language.dart';
import 'package:dio_nexus/src/utility/custom_logger.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

@freezed
/// The NetworkExceptions class is an abstract class that provides a set of network-related exception
/// types.
abstract class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled(String? reason) =
      RequestCancelled;

  const factory NetworkExceptions.unauthorisedRequest(String? reason) =
      UnauthorisedRequest;

  const factory NetworkExceptions.badRequest(String? reason) = BadRequest;

  const factory NetworkExceptions.notFound(String? reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed(String? reason) =
      MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable(String? reason) = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.receiveTimeout() = ReceiveTimeout;

  const factory NetworkExceptions.connectionError(String? reason) =
      ConnectionError;

  const factory NetworkExceptions.conflict(String? reason) = Conflict;

  const factory NetworkExceptions.forbiddenRequest(String? reason) =
      ForbiddenRequest;

  const factory NetworkExceptions.internalServerError(String? reason) =
      InternalServerError;

  const factory NetworkExceptions.badCertificate(String? reason) =
      BadCertificate;

  const factory NetworkExceptions.notImplemented(String? reason) =
      NotImplemented;

  const factory NetworkExceptions.serviceUnavailable(String? reason) =
      ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError({required String error}) =
      DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions getDioException(
    dynamic error,
    bool? printLogsDebugMode,
  ) {
    CustomLogger(data: error.toString()).show(printLogsDebugMode ?? false);
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              networkExceptions = NetworkExceptions.requestCancelled(
                error.response?.data.toString(),
              );
            case DioExceptionType.connectionTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
            case DioExceptionType.unknown:
              networkExceptions = NetworkExceptions.defaultError(
                error:
                    error.response?.data.toString() ?? error.error.toString(),
              );
            case DioExceptionType.receiveTimeout:
              networkExceptions = const NetworkExceptions.receiveTimeout();
            case DioExceptionType.badResponse:
              switch (error.response?.statusCode) {
                case 400:
                  networkExceptions = NetworkExceptions.badRequest(
                    error.response?.data.toString(),
                  );
                case 401:
                  networkExceptions = NetworkExceptions.unauthorisedRequest(
                    error.response?.data.toString(),
                  );
                case 403:
                  networkExceptions = NetworkExceptions.forbiddenRequest(
                    error.response?.data.toString(),
                  );
                case 404:
                  networkExceptions = NetworkExceptions.notFound(
                    error.response?.data.toString(),
                  );
                case 409:
                  networkExceptions = NetworkExceptions.conflict(
                    error.response?.data.toString(),
                  );
                case 408:
                  networkExceptions = const NetworkExceptions.requestTimeout();
                case 500:
                  networkExceptions = NetworkExceptions.internalServerError(
                    error.response?.data.toString(),
                  );
                case 503:
                  networkExceptions = NetworkExceptions.serviceUnavailable(
                    error.response?.data.toString(),
                  );
                default:
                  var responseCode = error.response?.statusCode;
                  networkExceptions = NetworkExceptions.defaultError(
                    error: 'Received invalid status code: $responseCode',
                  );
              }
            case DioExceptionType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
            case DioExceptionType.badCertificate:
              networkExceptions = NetworkExceptions.badCertificate(
                error.response?.data.toString(),
              );
            case DioExceptionType.connectionError:
              networkExceptions = NetworkExceptions.connectionError(
                error.response?.data.toString(),
              );
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  /// The function returns an error message based on the given network exception.
  /// 
  /// Args:
  ///   networkExceptions (NetworkExceptions): The parameter "networkExceptions" is of type
  /// NetworkExceptions.
  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var exceptionReason = '';

    networkExceptions.when(
      notImplemented: (String? reason) {
        exceptionReason = NexusLanguage.getLangValue.notImplemented;
      },
      requestCancelled: (String? reason) {
        exceptionReason = NexusLanguage.getLangValue.requestCancelled;
      },
      internalServerError: (String? reason) {
        exceptionReason = NexusLanguage.getLangValue.internalServerError;
      },
      notFound: (String? reason) {
        exceptionReason = reason ?? NexusLanguage.getLangValue.notFound;
      },
      serviceUnavailable: (String? reason) {
        exceptionReason = NexusLanguage.getLangValue.serviceUnavailable;
      },
      methodNotAllowed: (String? reason) {
        exceptionReason = NexusLanguage.getLangValue.methodNotAllowed;
      },
      badRequest: (String? reason) {
        exceptionReason = reason ?? NexusLanguage.getLangValue.badRequest;
      },
      unauthorisedRequest: (String? reason) {
        exceptionReason =
            reason ?? NexusLanguage.getLangValue.unauthorisedRequest;
      },
      unexpectedError: () {
        exceptionReason = NexusLanguage.getLangValue.unexpectedError;
      },
      requestTimeout: () {
        exceptionReason = NexusLanguage.getLangValue.requestTimeout;
      },
      noInternetConnection: () {
        exceptionReason =
            NexusLanguage.getLangValue.networkConnectionNoInternetConnection;
      },
      conflict: (String? reason) {
        exceptionReason = NexusLanguage.getLangValue.conflict;
      },
      sendTimeout: () {
        exceptionReason = NexusLanguage.getLangValue.sendTimeout;
      },
      unableToProcess: () {
        exceptionReason = NexusLanguage.getLangValue.unableToProcess;
      },
      defaultError: (String error) {
        exceptionReason = error;
      },
      formatException: () {
        exceptionReason = NexusLanguage.getLangValue.formatException;
      },
      notAcceptable: (String? reason) {
        exceptionReason = NexusLanguage.getLangValue.notAcceptable;
      },
      badCertificate: (String? reason) {
        exceptionReason = reason ?? NexusLanguage.getLangValue.badCertificate;
      },
      connectionError: (String? reason) {
        exceptionReason = NexusLanguage.getLangValue.connectionError;
      },
      receiveTimeout: () {
        exceptionReason = NexusLanguage.getLangValue.receiveTimeout;
      },
      forbiddenRequest: (String? reason) {
        exceptionReason = reason ?? NexusLanguage.getLangValue.forbiddenRequest;
      },
    );
    return exceptionReason;
  }
}
