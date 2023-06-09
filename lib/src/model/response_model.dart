import 'package:dio_nexus/dio_nexus.dart';

class ResponseModel<R> extends IResponseModel<R> {
  ResponseModel(super.model, super.errorModel);
}
