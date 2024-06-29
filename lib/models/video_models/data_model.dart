// import 'package:palestine_commercial_directory/models/video_models/video_model.dart';
//
// class DataModel {
//   final List<VideoModel>? videos;
//   final int? cursor;
//   final bool? hasMore;
//
//   DataModel({
//     this.videos,
//     this.cursor,
//     this.hasMore,
//   });
//
//   factory DataModel.fromMap(Map<String, dynamic> json) => DataModel(
//         videos: json["videos"] == null
//             ? []
//             : List<VideoModel>.from(
//                 json["videos"]!.map((x) => VideoModel.fromMap(x))),
//         cursor: json["cursor"],
//         hasMore: json["has_more"],
//       );
//
//   Map<String, dynamic> toMap() => {
//         "videos": videos == null
//             ? []
//             : List<dynamic>.from(videos!.map((x) => x.toMap())),
//         "cursor": cursor,
//         "has_more": hasMore,
//       };
// }
