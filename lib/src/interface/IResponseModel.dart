import 'package:dio_nexus/dio_nexus.dart';

abstract class IResponseModel<R> {
  R? model;
  IErrorModel? errorModel;
  IResponseModel(this.model, this.errorModel);

  @override
  String toString() {
    return 'IResponseModel(\nmodel: $model, \nerrorModel: $errorModel\n)';
  }
}
