part of '../dio_nexus_manager.dart';

/// Must be top-level function
dynamic _parseAndDecode(String response) {
  return jsonDecode(response);
}

dynamic parseJson(String body) {
  return compute(_parseAndDecode, body);
}

R? _modelResponseData<T extends IDioNexusNetworkModel<T>, R>(
    T responseModel, dynamic responseData, bool? printLogsDebugMode) {
  try {
    if (responseData is List) {
      return responseData.map((e) => responseModel.fromJson(e)).toList() as R;
    } else if (responseData is Map<String, dynamic>) {
      return responseModel.fromJson(responseData) as R;
    } else {
      CustomLogger(data: "$responseData cannot be parsed")
          .show(printLogsDebugMode ?? false);
    }
  } catch (err) {
    CustomLogger(data: " $err \n\n $R CAN'T PARSE TO $responseData")
        .show(printLogsDebugMode ?? false);
  }
  return null;
}
