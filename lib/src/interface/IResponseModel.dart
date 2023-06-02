abstract class IResponseModel<R> {
  R? model;
  int? statusCode;
  String? errorMessage;
  IResponseModel(this.model, this.statusCode, this.errorMessage);
}
