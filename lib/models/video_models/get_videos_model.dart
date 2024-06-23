import '../basic_models/post_model.dart';

class GetVideosModel {
  final bool? status;
  final List<PostModel>? videos;

  GetVideosModel({
    this.status,
    this.videos,
  });

  factory GetVideosModel.fromMap(Map<String, dynamic> json) => GetVideosModel(
    status: json["status"],
    videos: json["videos"] == null ? [] : List<PostModel>.from(json["videos"]!.map((x) => PostModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x.toMap())),
  };
}
