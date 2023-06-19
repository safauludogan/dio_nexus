// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio_nexus/dio_nexus.dart';

class NexusModel<T> extends IDioNexusNetworkModel<NexusModel> {
  T? value;
  NexusModel({this.value});

  @override
  NexusModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return;
    }
    value = json['name'] as T;
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, Object>{};
    data['name'] = value ?? '';
    return data;
  }

  @override
  NexusModel fromJson(Map<String, dynamic>? json) {
    return NexusModel.fromJson(json);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NexusModel && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
  Type get modelType => T;

  @override
  String toString() => 'NexusModel(value: $value)';

}
