// import 'package:videos_application/models/user_model.dart';

//model for used when create/update a post
class SinglePostModel {
  final bool? status;
  final String? message;
  final Post? post;

  SinglePostModel({
    this.status,
    this.message,
    this.post,
  });

  factory SinglePostModel.fromJson(Map<String, dynamic> json) =>
      SinglePostModel(
        status: json["status"],
        message: json["message"],
        post: json["post"] == null ? null : Post.fromJson(json["post"]),
      );
}

class Post {
  final String? pTitle;
  final String? pContent;
  final String? pContentAr;
  final int? pUserId;
  final String? pType;
  final String? pImage;
  final String? pVideo;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? pId;
  final int? likesCount;
  final User? user;

  Post(
      {this.pTitle,
      this.pContent,
      this.pContentAr,
      this.pUserId,
      this.pType,
      this.pImage,
      this.pVideo,
      this.updatedAt,
      this.createdAt,
      this.pId,
      this.likesCount,
      this.user});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        pId: json["p_id"],
        pTitle: json["p_title"],
        pContent: json["p_content"],
        pContentAr: json["p_content_ar"],
        pUserId: json["p_user_id"],
        pType: json["p_type"],
        pImage: json["p_image"],
        pVideo: json["p_video"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        likesCount: json["likes_count"] ?? 0,
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "p_id": pId,
        "p_title": pTitle,
        "p_content": pContent,
        "p_content_ar": pContentAr,
        "p_image": pImage,
        "p_video": pVideo,
        "p_type": pType,
        "p_user_id": pUserId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "likes_count": likesCount,
        "user": user?.toJson(),
      };
}

class User {
  final int? uId;
  final String? uName;
  final String? uNameAr;
  final String? uImage;

  User({
    this.uId,
    this.uName,
    this.uNameAr,
    this.uImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        uId: json["u_id"],
        uNameAr: json["u_name_ar"] ?? 'ar',
        uName: json["u_name"] ?? 'en',
        uImage: json["u_image"],
      );

  Map<String, dynamic> toJson() => {
        "u_id": uId,
        "u_name": uName,
        "u_image": uImage,
        "u_name_ar": uNameAr,
      };
}
