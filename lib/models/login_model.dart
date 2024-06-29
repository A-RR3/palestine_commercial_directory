import 'dart:convert';

import 'package:palestine_commercial_directory/models/user_model.dart';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

class LoginModel {
  final bool status;
  final String? message;
  final User? user;
  final String? token;

  LoginModel({required this.status, this.message, this.user, this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
      );
}
