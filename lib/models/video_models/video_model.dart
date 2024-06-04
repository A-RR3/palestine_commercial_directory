// class VideoModel {
//   final String? id;
//   final String? user;
//   final String? userPic;
//   final String? videoTitle;
//   final String? songName;
//   final String? likes;
//   final String? comments;
//   final String? url;
//
//   // VideoPlayerController? videoPlayerController;
//
//   VideoModel({
//     this.id,
//     this.user,
//     this.userPic,
//     this.videoTitle,
//     this.songName,
//     this.likes,
//     this.comments,
//     this.url,
//   });
//
//   factory VideoModel.fromMap(Map<String, dynamic> json) => VideoModel(
//         id: json["id"],
//         videoTitle: json["video_title"],
//         url: json["url"],
//         comments: json["comments"],
//         likes: json["likes"],
//         songName: json["song_name"],
//         user: json["user"],
//         userPic: json["user_pic"],
//       );
//
//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "video_title": videoTitle,
//         "url": url,
//         "comments": comments,
//         "likes": likes,
//         "song_name": songName,
//         "user": user,
//         "user_pic": userPic,
//       };
//   //
//   // Future<void> loadController() async {
//   //   videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url!));
//   //   await videoPlayerController?.initialize();
//   //   videoPlayerController?.setLooping(true);
//   //   videoPlayerController?.play();
//   // }
//
//
//
// }
