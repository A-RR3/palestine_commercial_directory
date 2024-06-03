import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:videos_application/modules/videos_modules/videos_cubit/videos_cubit.dart';

import '../../models/video_models/video_model.dart';

class VideoCard extends StatefulWidget {
  final VideoModel videoModel;
  final VideosCubit videosCubit;

  const VideoCard({
    super.key,
    required this.videoModel,
    required this.videosCubit,
  });

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {

  @override
  void initState() {

    super.initState();
    widget.videosCubit.loadController(videoModel: widget.videoModel);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.videoModel.videoPlayerController != null
            ? GestureDetector(
                onTap: () {
                  print('vid clicked');
                  if (widget.videoModel.videoPlayerController!.value.isPlaying) {
                    widget.videosCubit.pauseVideo(widget.videoModel.videoPlayerController!);
                  } else {
                    widget.videosCubit.playVideo(widget.videoModel.videoPlayerController!);
                  }
                },
                child: SizedBox.expand(
                    child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width:
                        widget.videoModel.videoPlayerController!.value.size.width ?? 0,
                    height:
                        widget.videoModel.videoPlayerController!.value.size.height ??
                            0,
                    child: VideoPlayer(widget.videoModel.videoPlayerController!),
                  ),
                )),
              )
            : Container(
                color: Colors.black,
                child: const Center(
                  child: Text("Loading"),
                ),
              ),
        // TextButton(
        //     onPressed: () {
        //       widget.videosCubit.newState();
        //     },
        //     child: Text('click'))
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: <Widget>[
        //     Row(
        //       mainAxisSize: MainAxisSize.max,
        //       crossAxisAlignment: CrossAxisAlignment.end,
        //       children: <Widget>[
        //         VideoDescription(videoModel.user, videoModel.videoTitle,
        //             videoModel.songName),
        //         ActionsToolbar(videoModel.likes, videoModel.comments,
        //             "https://www.andersonsobelcosmetic.com/wp-content/uploads/2018/09/chin-implant-vs-fillers-best-for-improving-profile-bellevue-washington-chin-surgery.jpg"),
        //       ],
        //     ),
        //     SizedBox(height: 20)
        //   ],
        // ),
      ],
    );
  }
}
