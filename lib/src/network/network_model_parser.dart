part of '../dio_nexus_manager.dart';

/// Must be top-level function
Map<String, dynamic> _parseAndDecode(String response) {
  return jsonDecode(response) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> parseJson(String text) {
  return compute(_parseAndDecode, text);
}

R? _modelResponseData<T extends IDioNexusNetworkModel<T>, R>(
    T responseModel, dynamic responseData) {
  try {
    if (responseData is List) {
      return responseData.map((e) => responseModel.fromJson(e)).toList() as R;
    } else if (responseData is Map<String, dynamic>) {
      return responseModel.fromJson(responseData) as R;
    } else {
      CustomLogger(data: "$responseData cannot be parsed").show();
    }
  } catch (err) {
    CustomLogger(data: " $err \n\n $R CAN'T PARSE TO $responseData").show();
  }
  return null;
}
