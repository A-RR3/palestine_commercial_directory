import 'package:videos_application/models/video_model.dart';

class GetVideosModel {
  final DataModel? data;
  final Error? error;

  GetVideosModel({
    this.data,
    this.error,
  });

  factory GetVideosModel.fromMap(Map<String, dynamic> json) => GetVideosModel(
        data: json["data"] == null ? null : DataModel.fromMap(json["data"]),
        error: json["error"] == null ? null : Error.fromMap(json["error"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "error": error?.toMap(),
      };
}

class DataModel {
  final List<VideoModel>? videos;
  final int? cursor;
  final bool? hasMore;

  DataModel({
    this.videos,
    this.cursor,
    this.hasMore,
  });

  factory DataModel.fromMap(Map<String, dynamic> json) => DataModel(
        videos: json["videos"] == null
            ? []
            : List<VideoModel>.from(
                json["videos"]!.map((x) => VideoModel.fromMap(x))),
        cursor: json["cursor"],
        hasMore: json["has_more"],
      );

  Map<String, dynamic> toMap() => {
        "videos": videos == null
            ? []
            : List<dynamic>.from(videos!.map((x) => x.toMap())),
        "cursor": cursor,
        "has_more": hasMore,
      };
}

class Error {
  final String? code;
  final String? message;
  final String? logId;

  Error({
    this.code,
    this.message,
    this.logId,
  });

  factory Error.fromMap(Map<String, dynamic> json) => Error(
        code: json["code"],
        message: json["message"],
        logId: json["log_id"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "message": message,
        "log_id": logId,
      };
}
