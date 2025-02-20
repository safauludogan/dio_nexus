import 'package:dio_nexus/src/network/index.dart';

/// The IErrorModel interface is a generic interface that defines the structure of an error model.
abstract class IErrorModel {
  /// The constructor of the IErrorModel class.
  IErrorModel(
    this.statusCode,
    this.errorMessage,
    this.networkException,
  );

  /// The status code of the error.
  int? statusCode;

  /// The error message of the error.
  String? errorMessage;

  /// The network exception of the error.
  NetworkExceptions? networkException;

  @override
  String toString() =>
      'IErrorModel(statusCode: $statusCode, errorMessage: $errorMessage, networkException: $networkException)';
}
