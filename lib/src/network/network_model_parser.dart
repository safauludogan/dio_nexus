part of '../dio_nexus_manager.dart';

/// Must be top-level function
dynamic _parseAndDecode(String response) {
  return jsonDecode(response);
}

dynamic parseJson(String body) async {
  try {
    return await compute(_parseAndDecode, body);
  } catch (e) {
    return body;
  }
}

R? _modelResponseData<T extends IDioNexusNetworkModel<T>, R>(
    T responseModel, dynamic responseData, bool? printLogsDebugMode) {
  try {
    if (responseData is List) {
      return responseData.map((e) => responseModel.fromJson(e)).toList() as R;
    } else if (responseData is Map<String, dynamic>) {
      return responseModel.fromJson(responseData) as R;
    } else if ((responseModel is NexusModel) &&
        (responseModel as NexusModel).modelType == responseData.runtimeType) {
      return genericNexusModelConverter(responseData) as R;
    } else {
      CustomLogger(
              data:
                  "$responseData data is [${responseData.runtimeType}] cannot be parsed as $R")
          .show(printLogsDebugMode ?? false);
    }
  } catch (err) {
    CustomLogger(data: " $err \n\n $R CAN'T PARSE TO $responseData")
        .show(printLogsDebugMode ?? false);
  }
  return null;
}

dynamic genericNexusModelConverter(dynamic data) {
  if (data.runtimeType == int) {
    return NexusModel<int>(value: data);
  } else if (data.runtimeType == String) {
    return NexusModel<String>(value: data);
  } else if (data.runtimeType == bool) {
    return NexusModel<bool>(value: data);
  } else if (data.runtimeType == double) {
    return NexusModel<double>(value: data);
  } else if (data.runtimeType == dynamic) {
    return NexusModel<dynamic>(value: data);
  }
}
