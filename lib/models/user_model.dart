import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int? currentPage;
  final int? lastPage;
  final List<User>? users;

  UserModel({
    this.currentPage,
    this.lastPage,
    this.users,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "last_page": lastPage,
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
      };
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

  User({
    this.uId,
    this.uName,
    this.uPhone,
    this.uRoleId,
    this.uStatus,
    this.createdAt,
    this.updatedAt,
    this.companiesCount,
    this.companies,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        uId: json["u_id"],
        uName: json["u_name"],
        uPhone: json["u_phone"],
        uRoleId: json["u_role_id"],
        uStatus: json["u_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        companiesCount: json["companies_count"],
        companies: json["companies"] == null
            ? []
            : List<Company>.from(
                json["companies"]!.map((x) => Company.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "u_id": uId,
        "u_name": uName,
        "u_phone": uPhone,
        "u_role_id": uRoleId,
        "u_status": uStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "companies_count": companiesCount,
        "companies": companies == null
            ? []
            : List<dynamic>.from(companies!.map((x) => x.toJson())),
      };
}

class Company {
  final int? cId;
  final int? cOwnerId;
  final String? cName;
  final String? cPhone;

  Company({
    this.cId,
    this.cOwnerId,
    this.cName,
    this.cPhone,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        cId: json["c_id"],
        cOwnerId: json["c_owner_id"],
        cName: json["c_name"],
        cPhone: json["c_phone"],
      );

  Map<String, dynamic> toJson() => {
        "c_id": cId,
        "c_owner_id": cOwnerId,
        "c_name": cName,
        "c_phone": cPhone,
      };
}
