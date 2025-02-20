import 'package:dio_nexus/src/interface/index.dart';

/// [IResponseModel] is an interface that defines the structure of a response model.
abstract class IResponseModel<R> {
  /// [IResponseModel] is a constructor that initializes the data and error model of the response model.
  IResponseModel(this.data, this.errorModel);

  /// [data] is the data of the response model.
  R? data;

  /// [errorModel] is the error model of the response model.
  IErrorModel? errorModel;

  /// [toString] is a method that returns the string representation of the response model.
  @override
  String toString() {
    return 'IResponseModel(\ndata: $data, \nerrorModel: $errorModel\n)';
  }
}
