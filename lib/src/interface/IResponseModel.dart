import 'package:dio_nexus/dio_nexus.dart';

abstract class IResponseModel<R> {
  R? model;
  int? statusCode;
  String? errorMessage;
  DioErrorType? dioErrorType;
  IResponseModel(
      this.model, this.statusCode, this.errorMessage, this.dioErrorType);
}
