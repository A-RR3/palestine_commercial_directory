import '../basic_models/post_model.dart';

class UploadVideoModel {
  final bool? status;
  final String? message;
  final PostModel? post;

  UploadVideoModel({
    this.status,
    this.message,
    this.post,
  });

  factory UploadVideoModel.fromMap(Map<String, dynamic> json) => UploadVideoModel(
    status: json["status"],
    message: json["message"],
    post: json["post"] == null ? null : PostModel.fromMap(json["post"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "post": post?.toMap(),
  };
}

