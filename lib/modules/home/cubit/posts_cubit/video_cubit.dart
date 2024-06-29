import 'package:chewie/chewie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:palestine_commercial_directory/modules/home/cubit/posts_cubit/posts_states.dart';
import 'package:palestine_commercial_directory/shared/network/remote/end_points.dart';

class VideoCubit extends Cubit<PostsStates> {
  VideoCubit() : super(PostsInitialState());

  static VideoCubit get(context) => BlocProvider.of(context);

  late VideoPlayerController controller;
  ChewieController? chewieController;
  final bool _isPlaying = false;

  @override
  Future<void> close() {
    controller.dispose();
    chewieController?.dispose();
    return super.close();
  }

  void viewVideo(String videoPath) {
    emit(ShowPostVideoInitialState());
    controller = VideoPlayerController.networkUrl(
        Uri.parse('${EndPointsConstants.videosStorage}$videoPath'))
      ..initialize().then((_) {
        controller.setVolume(1.0);
        chewieController = ChewieController(
          videoPlayerController: controller,
          aspectRatio: controller.value.aspectRatio,
          autoPlay: false,
          looping: false,
          autoInitialize: true,
        );
        emit(ShowPostVideoSuccessState());
      });
  }

  void togglePlayPause() {
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
  }
}
