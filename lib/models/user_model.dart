import 'dart:ui';

import 'package:videos_application/core/values/constants.dart';

class UserModel {
  final int? status;
  final List<User>? users;
  final Pagination? pagination;

  UserModel({
    this.status,
    this.users,
    this.pagination,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );
}

class Pagination {
  final int? currentPage;
  final int? lastPage;
  final int? perPage;

  Pagination({
    this.currentPage,
    this.lastPage,
    this.perPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        perPage: json["per_page"],
      );
}

class User {
  final int? uId;
  final String? uName;
  final String? uPhone;
  final int? uRoleId;
  final bool? uStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? companiesCount;
  final List<Company>? companies;

  User(
      {this.uId,
      this.uName,
      this.uPhone,
      this.uRoleId,
      this.uStatus,
      this.createdAt,
      this.updatedAt,
      this.companiesCount,
      this.companies});

  factory User.fromJson(Map<String, dynamic> json) => User(
      uId: json["u_id"],
      uName: userLocale == const Locale('en') ? json["u_name"] : json["u_name_ar"],
      uPhone: json["u_phone"],
      uRoleId: json["u_role_id"],
      uStatus: json["u_status"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      companiesCount: json["companies_count"],
      companies: json["companies"] == null
          ? []
          : List<Company>.from(
              json["companies"]!.map((x) => Company.fromJson(x))));
}

class Company {
  final int? cId;
  final int? cOwnerId;
  final String? cName;
  final String? cPhone;
  final String? image;

  Company({this.cId, this.cOwnerId, this.cName, this.cPhone, this.image});

  factory Company.fromJson(Map<String, dynamic> json) => Company(
      cId: json["c_id"],
      cOwnerId: json["c_owner_id"],
      cName: userLocale == const Locale('en') ? json["c_name"] : json["c_name_ar"],
      cPhone: json["c_phone"],
      image: json["c_image"]);
}
