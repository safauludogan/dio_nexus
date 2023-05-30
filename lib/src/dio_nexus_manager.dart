import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:dio_nexus/src/utility/custom_logger.dart';
import 'interface/index.dart';
import 'model/enum/request_type.dart';
import 'package:flutter/foundation.dart';

part './utility/network_model_parser.dart';

class DioNexusManager with DioMixin implements Dio, IDioNexusManager {
  DioNexusManager({required BaseOptions options}) {
    this.options = options;
    (transformer as BackgroundTransformer).jsonDecodeCallback = parseJson;
    httpClientAdapter = HttpClientAdapter();
  }

  @override
  Future<R?> sendRequest<T extends IDioNexusNetworkModel<T>, R>(
    String path, {
    Object? data,
    required T responseModel,
    required RequestType requestType,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    options ??= Options();
    options.method = requestType.name;

    //try {
    var response = await request(path,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: options,
        onSendProgress: onSendProgress);
    var _response = response.data;
    if (response.data is String) {
      var _response = await parseJson(response.data);
    }
    var result = _modelResponseData<T, R>(responseModel, _response);
    return result;
    //} on DioError catch (err) {
    //print(err.message.toString());
    // return null;
    //}
  }
}
