import 'package:palestine_commercial_directory/models/pagination_model.dart';
import 'company_model.dart';

class UserModel {
  final bool? status;
  final List<User>? users;
  final Pagination? pagination;

  UserModel({
    this.status,
    this.users,
    this.pagination,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        users: json["users"] != null
            ? (json["users"] as List).map((x) => User.fromJson(x)).toList()
            : [],
        pagination: Pagination.fromJson(json["pagination"]),
      );
}

class User {
  final int? uId;
  final String? uName;
  final String? uNameAr;
  final String? uPhone;
  final int? uRoleId;
  final bool? uStatus;
  final String? uImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? companiesCount;
  final List<CompanyModel>? companies;

  User(
      {this.uId,
      this.uName,
      this.uNameAr,
      this.uPhone,
      this.uRoleId,
      this.uStatus,
      this.uImage,
      this.createdAt,
      this.updatedAt,
      this.companiesCount,
      this.companies});

  factory User.fromJson(Map<String, dynamic> json) => User(
      uId: json["u_id"],
      uPhone: json["u_phone"],
      uNameAr: json["u_name_ar"] ?? 'ar',
      uName: json["u_name"] ?? 'en',
      uRoleId: json["u_role_id"],
      uStatus: json["u_status"],
      uImage: json["u_image"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      companiesCount: json["companies_count"],
      companies: []);

  // factory User.fromJson(Map<String, dynamic> json) => User(
  //     uId: 2,
  //     uPhone: "0599887766",
  //     uNameAr: "اروى",
  //     uName: "arwa arafeh",
  //     uRoleId: 2,
  //     uStatus: true,
  //     createdAt: DateTime.parse(json["created_at"]),
  //     updatedAt: DateTime.parse(json["updated_at"]),
  //     uImage: "1719061821_6676cd3d21bf4.jpg",
  //     companiesCount: 2,
  //     companies: []);

  Map<String, dynamic> toJson() => {
        "u_id": uId,
        "u_name": uName,
        "u_image": uImage,
        "u_name_ar": uNameAr,
      };
}
