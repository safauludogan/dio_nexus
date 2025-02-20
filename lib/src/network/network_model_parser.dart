part of '../dio_nexus_manager.dart';

/// [R] is the type of the response data.
/// Example:
/// [R] can be Model or [List<Model>]
///
/// [T] is the type of the response model.
/// [T] must be Model
/// [T] has fromJson method and fromJson method
R? _parseResponseData<T extends IDioNexusNetworkModel<T>, R>(
  T responseModel,
  dynamic data, {
  bool? printLogsDebugMode,
}) {
  try {
    if (data is List) {
      return data
          .map((e) => responseModel.fromJson(e as Map<String, dynamic>))
          .toList() as R;
    } else if (data is Map<String, dynamic>) {
      return responseModel.fromJson(data) as R;
    } else {
      CustomLogger(
        data: '$data data is [${data.runtimeType}] cannot be parsed as $R',
      ).show(printLog: printLogsDebugMode ?? false);
    }
  } catch (err) {
    CustomLogger(data: " $err \n\n $R CAN'T PARSE TO $data")
        .show(printLog: printLogsDebugMode ?? false);
  }
  return null;
}

/// R is primitive type
/// Example:
/// [R] can be String, int, double, bool
/// [R] can be List<String>, List<int>, List<double>, List<bool>
R? _parsePrimitiveResponseData<R>(dynamic data, {bool? printLogsDebugMode}) {
  try {
    if (data is String || data is int || data is double || data is bool) {
      return data as R;
    } else if (data is List) {
      return _parsePrimitiveListData<R>(data);
    } else {
      CustomLogger(
        data: '$data primitive data cannot be parsed as $R',
      ).show(printLog: printLogsDebugMode ?? false);
    }
  } catch (err) {
    CustomLogger(data: " $err \n\n $R CAN'T PARSE TO $data")
        .show(printLog: printLogsDebugMode ?? false);
  }
  return null;
}

/// List<R> is the type of the response data.
/// Example:
/// [R] can be String, int, double, bool
/// [R] can be List<String>, List<int>, List<double>, List<bool>
R? _parsePrimitiveListData<R>(List<dynamic> datas) {
  if (datas.every((e) => e is String)) {
    return List<String>.from(datas) as R;
  } else if (datas.every((e) => e is int)) {
    return List<int>.from(datas) as R;
  } else if (datas.every((e) => e is double)) {
    return List<double>.from(datas) as R;
  } else if (datas.every((e) => e is bool)) {
    return List<bool>.from(datas) as R;
  }
  return null;
}

/// Must be top-level function
dynamic _parseAndDecode(String response) {
  return jsonDecode(response);
}

/// The function `parseJson` takes a string parameter `body` and returns a dynamic object representing
/// the parsed JSON data.
///
/// Args:
///   body (String): The `body` parameter is a string that represents the JSON data that you want to
/// parse.
dynamic parseJson(String body) async {
  try {
    return await compute(_parseAndDecode, body);
  } catch (e) {
    return body;
  }
}
