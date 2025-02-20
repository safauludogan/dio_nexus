/// The type of the model.
abstract class IDioNexusNetworkModel<T> {
  /// Converts the model to a JSON object.
  ///
  /// Returns: A JSON object representing the model.
  Map<String, dynamic> toJson();

  /// Converts a JSON object to a model.
  ///
  /// [json]: The JSON object to convert.
  T fromJson(Map<String, dynamic> json);
}
