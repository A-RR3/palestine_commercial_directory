import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:palestine_commercial_directory/models/basic_models/post_model.dart';
import 'package:palestine_commercial_directory/modules/videos_modules/videos_cubit/videos_cubit.dart';

class VideoCard extends StatefulWidget {
  final PostModel postModel;
  final VideosCubit videosCubit;

  const VideoCard({
    super.key,
    required this.postModel,
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
      postModel: widget.postModel,
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
                    width: videoPlayerController!.value.size.width,
                    height: videoPlayerController!.value.size.height,
                    child: VideoPlayer(videoPlayerController!),
                  ),
                )),
              )
            : Container(
                color: Colors.white,
                child: const Center(
                  child: Text(''),
                ),
              ),
      ],
    );
  }
}
