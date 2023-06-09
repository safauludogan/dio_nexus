import 'package:dio_nexus/src/interface/IErrorModel.dart';

class ErrorModel extends IErrorModel {
  ErrorModel(super.statusCode, super.errorMessage, super.dioErrorType);
}
