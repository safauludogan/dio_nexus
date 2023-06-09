// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio_nexus/dio_nexus.dart';

abstract class IErrorModel {
  int? statusCode;
  String? errorMessage;
  NetworkExceptions? networkException;
  IErrorModel(
    this.statusCode,
    this.errorMessage,
    this.networkException,
  );

  @override
  String toString() =>
      'IErrorModel(statusCode: $statusCode, errorMessage: $errorMessage, networkException: $networkException)';
}
