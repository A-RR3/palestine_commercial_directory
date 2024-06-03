import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

class LoginModel {
  final bool status;
  final String? message;
  final UserData? user;
  final String? token;

  LoginModel({required this.status, this.message, this.user, this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        user: json["user"] == null ? null : UserData.fromJson(json["user"]),
        token: json["token"],
      );
}

class UserData {
  final int? id;
  final String? name;
  final String? phone;
  final int? role;
  final int? status;

  UserData(
      {this.id,
      required this.name,
      required this.phone,
      this.role,
      this.status});

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
      id: json["u_id"],
      name: json["u_name"],
      phone: json["u_phone"],
      role: json["u_role_id"]);
}
