// To parse this JSON data, do
//
//     final loginCredentials = loginCredentialsFromJson(jsonString);

import 'dart:convert';

LoginCredentials loginCredentialsFromJson(String str) =>
    LoginCredentials.fromJson(json.decode(str));

String loginCredentialsToJson(LoginCredentials data) =>
    json.encode(data.toJson());

class LoginCredentials {
  dynamic email;
  dynamic name;
  dynamic phoneNumber;
  Tokens tokens;
  dynamic id;
  bool isSaccoAdmin;

  LoginCredentials({
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.tokens,
    required this.id,
    required this.isSaccoAdmin,
  });

  factory LoginCredentials.fromJson(Map<dynamic, dynamic> json) =>
      LoginCredentials(
        email: json["email"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        tokens: Tokens.fromJson(json["tokens"]),
        id: json["id"],
        isSaccoAdmin: json["is_sacco_admin"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "phone_number": phoneNumber,
        "tokens": tokens.toJson(),
        "id": id,
        "is_sacco_admin": isSaccoAdmin,
      };
}

class Tokens {
  String refresh;
  String access;

  Tokens({
    required this.refresh,
    required this.access,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        refresh: json["refresh"],
        access: json["access"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
      };
}
