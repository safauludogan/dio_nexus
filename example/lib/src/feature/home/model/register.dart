import 'package:dio_nexus/dio_nexus.dart';

class Register extends IDioNexusNetworkModel<Register> {
  String? email;

  Register({
    this.email,
  });

  Register copyWith({
    String? email,
  }) {
    return Register(
      email: email ?? this.email,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      email: json['email'] as String?,
    );
  }

  @override
  String toString() => "Register(email: $email)";

  @override
  Register fromJson(Map<String, dynamic> json) => Register.fromJson(json);
}
