import 'package:dio_nexus/src/interface/IErrorModel.dart';

/// [ErrorModel] is a class that is used to handle errors.
class ErrorModel extends IErrorModel {
  /// [ErrorModel] is a constructor that is used to initialize the [ErrorModel] class.
  ErrorModel(super.statusCode, super.errorMessage, super.dioErrorType);
}
