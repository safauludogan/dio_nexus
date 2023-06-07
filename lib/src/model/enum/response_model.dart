import 'package:dio_nexus/src/interface/IResponseModel.dart';

class ResponseModel<R> extends IResponseModel<R> {
  ResponseModel(super.model, super.statusCode, super.errorMessage, super.dioErrorType);
}
