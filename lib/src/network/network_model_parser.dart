part of '../dio_nexus_manager.dart';

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

R? _modelResponseData<T extends IDioNexusNetworkModel<T>, R>(
  T responseModel,
  dynamic responseData,
  bool? printLogsDebugMode,
) {
  try {
    if (responseData is List) {
      return responseData
          .map((e) => responseModel.fromJson(e as Map<String, dynamic>))
          .toList() as R;
    } else if (responseData is Map<String, dynamic>) {
      return responseModel.fromJson(responseData) as R;
    } else if ((responseModel is NexusModel) &&
        (responseModel as NexusModel).modelType == responseData.runtimeType) {
      return genericNexusModelConverter(responseData) as R;
    } else {
      CustomLogger(
        data:
            '$responseData data is [${responseData.runtimeType}] cannot be parsed as $R',
      ).show(printLogsDebugMode ?? false);
    }
  } catch (err) {
    CustomLogger(data: " $err \n\n $R CAN'T PARSE TO $responseData")
        .show(printLogsDebugMode ?? false);
  }
  return null;
}

/// The function converts a dynamic data object into a generic Nexus model.
///
/// Args:
///   data (dynamic): The "data" parameter is a dynamic variable, which means it can hold any type of
/// data. It is used as input to the method "genericNexusModelConverter".
dynamic genericNexusModelConverter(dynamic data) {
  if (data.runtimeType == int) {
    return NexusModel<int>(value: data as int);
  } else if (data.runtimeType == String) {
    return NexusModel<String>(value: data as String);
  } else if (data.runtimeType == bool) {
    return NexusModel<bool>(value: data as bool);
  } else if (data.runtimeType == double) {
    return NexusModel<double>(value: data as double);
  } else if (data.runtimeType == dynamic) {
    return NexusModel<dynamic>(value: data);
  }
}
