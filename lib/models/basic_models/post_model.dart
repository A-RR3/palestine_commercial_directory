class PostModel {
  final String? pTitle;
  final String? pContent;
  final String? pUserId;
  final String? pVideo;
  final String? pImage;
  final String? pType;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? pId;

  PostModel({
    this.pTitle,
    this.pContent,
    this.pUserId,
    this.pVideo,
    this.pImage,
    this.pType,
    this.updatedAt,
    this.createdAt,
    this.pId,
  });

  factory PostModel.fromMap(Map<String, dynamic> json) => PostModel(
    pTitle: json["p_title"],
    pContent: json["p_content"],
    pUserId: json["p_user_id"],
    pVideo: json["p_video"],
    pImage: json["p_image"],
    pType: json["p_type"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    pId: json["p_id"],
  );

  Map<String, dynamic> toMap() => {
    "p_title": pTitle,
    "p_content": pContent,
    "p_user_id": pUserId,
    "p_video": pVideo,
    "p_image": pImage,
    "p_type": pType,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "p_id": pId,
  };
}
