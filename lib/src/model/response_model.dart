import 'package:dio_nexus/src/interface/index.dart';

/// The ResponseModel class is a generic class that extends the IResponseModel interface.
/// It contains two properties: data and errorModel.
/// The data property is of type R, which is a generic type parameter.
/// The errorModel property is of type ErrorModel.
class ResponseModel<R> extends IResponseModel<R> {
  /// The constructor of the ResponseModel class.
  ResponseModel(super.data, super.errorModel);
}
