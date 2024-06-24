import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:videos_application/models/basic_models/post_model.dart';
import 'package:videos_application/models/video_models/get_videos_model.dart';
import 'package:videos_application/modules/videos_modules/videos_cubit/videos_states.dart';
import 'package:videos_application/shared/network/remote/dio_helper.dart';
import 'package:videos_application/shared/network/remote/end_points.dart';

class VideosCubit extends Cubit<VideosStates> {
  VideosCubit() : super(VideosInitialState());

  static VideosCubit get(context) => BlocProvider.of(context);

  GetVideosModel? getVideosModel;


  void getVideosData() {
    emit(GetVideosLoadingState());
    DioHelper.getData(url: EndPointsConstants.videos).then((value) {
      print(value?.data);
      getVideosModel = GetVideosModel.fromMap(value?.data);

      emit(GetVideosSuccessState());
    }).catchError((error) {
      emit(GetVideosErrorState(error: error.toString()));
      print(error.toString());
    });
  }

  Future<void> loadController({
    required PostModel postModel,
    required Function(VideoPlayerController?) onControllerLoaded,
  }) async {
    print('load controller');
    emit(LoadControllerStartState());
    try {
      print('postModel.pVideo: ${postModel.pVideo}');
      print(
          'EndPointsConstants.videosStorage + postModel.pVideo! ${EndPointsConstants.videosStorage + postModel.pVideo!}');
      VideoPlayerController controller = VideoPlayerController.networkUrl(
        Uri.parse(EndPointsConstants.videosStorage + postModel.pVideo!),
      );
      print(controller.value.toString());
      await controller.initialize();
      controller.play();
      controller.setLooping(true);
      print('load controller successfully');
      emit(LoadControllerEndSuccessfullyState());
      onControllerLoaded(controller); // Pass controller back to the caller
    } catch (error) {
      print('error in load controller: $error');
      emit(LoadControllerEndWithErrorState());
    }
  }

  void pauseVideo(VideoPlayerController videoPlayerController) {
    videoPlayerController.pause();
  }

  void playVideo(VideoPlayerController videoPlayerController) {
    videoPlayerController.play();
  }


  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
