import 'package:dio_nexus/dio_nexus.dart';

import 'data.dart';
import 'support.dart';

class SingleUser extends IDioNexusNetworkModel<SingleUser> {
  Data? data;
  Support? support;

  SingleUser({
    this.data,
    this.support,
  });

  SingleUser copyWith({
    Data? data,
    Support? support,
  }) {
    return SingleUser(
      data: data ?? this.data,
      support: support ?? this.support,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'support': support,
    };
  }

  factory SingleUser.fromJson(Map<String, dynamic> json) {
    return SingleUser(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      support: json['support'] == null
          ? null
          : Support.fromJson(json['support'] as Map<String, dynamic>),
    );
  }
  @override
  SingleUser fromJson(Map<String, dynamic> json) => SingleUser.fromJson(json);

  @override
  String toString() => "SingleUser(data: $data,support: $support)";

  @override
  int get hashCode => Object.hash(data, support);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SingleUser &&
          runtimeType == other.runtimeType &&
          data == other.data &&
          support == other.support;
}
