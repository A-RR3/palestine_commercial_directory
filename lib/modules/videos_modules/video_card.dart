import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:videos_application/modules/videos_modules/videos_cubit/videos_cubit.dart';

import '../../models/video_models/video_model.dart';

class VideoCard extends StatefulWidget {
  final VideoModel videoModel;
  final VideosCubit videosCubit;

  VideoCard({
    super.key,
    required this.videoModel,
    required this.videosCubit,
  });

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    print('start init');
    super.initState();
    // widget.videosCubit.loadController(
    //   videoModel: widget.videoModel,
    //   videoPlayerController: videoPlayerController,
    // );
    widget.videosCubit.loadController(
      videoModel: widget.videoModel,
      onControllerLoaded: (controller) {
        setState(() {
          videoPlayerController = controller;
        });
      },
    );
    print('end init');
  }

  @override
  void dispose() {
    print("dispoooooooooooooss");
    // widget.videosCubit
    //     .disposeController(videoPlayerController: videoPlayerController);
    if (videoPlayerController != null) {
      videoPlayerController!.pause();
      videoPlayerController!.dispose();
      videoPlayerController = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // videoPlayerController != null
        videoPlayerController != null
            // &&
            //     videoPlayerController!.value.isInitialized
            ? GestureDetector(
                onTap: () {
                  print('vid clicked');
                  if (videoPlayerController!.value.isPlaying) {
                    widget.videosCubit.pauseVideo(videoPlayerController!);
                  } else {
                    widget.videosCubit.playVideo(videoPlayerController!);
                  }
                },
                child: SizedBox.expand(
                    child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: videoPlayerController!.value.size.width ,
                    height: videoPlayerController!.value.size.height,
                    child: VideoPlayer(videoPlayerController!),
                  ),
                )),
              )
            : GestureDetector(
          onTap: (){

            widget.videosCubit.newState();
          },
              child: Container(
                  color: Colors.pink,
                  child: const Center(
                    child: Text("Loading"),
                  ),
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
