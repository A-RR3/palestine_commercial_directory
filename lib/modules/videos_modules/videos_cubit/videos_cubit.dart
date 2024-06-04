import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:videos_application/demo_data.dart';
import 'package:videos_application/models/basic_models/post_model.dart';
import 'package:videos_application/models/video_models/data_model.dart';
import 'package:videos_application/models/video_models/get_videos_model.dart';
import 'package:videos_application/modules/videos_modules/videos_cubit/videos_states.dart';
import 'package:videos_application/shared/network/remote/dio_helper.dart';
import 'package:videos_application/shared/network/remote/end_points.dart';

import '../../../models/video_models/video_model.dart';

class VideosCubit extends Cubit<VideosStates> {
  VideosCubit() : super(VideosInitialState());

  static VideosCubit get(context) => BlocProvider.of(context);

  GetVideosModel? getVideosModel;

  // DataModel? dataModel;

  // VideoModel? videoModel;

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

  // Future<void> loadController({
  //   required VideoModel videoModel,
  //   required VideoPlayerController? videoPlayerController,
  // }) async {
  //   print('load controller');
  //   emit(LoadControllerStartState());
  //   // await videoModel.loadController();
  //   videoPlayerController =
  //       VideoPlayerController.networkUrl(Uri.parse(videoModel.url!));
  //   await videoPlayerController.initialize().then((v) {
  //     videoPlayerController?.play();
  //     videoPlayerController?.setLooping(true);
  //     print('load controller successfully');
  //     emit(LoadControllerEndSuccessfullyState());
  //   }).catchError((error) {
  //     print('error in load controller');
  //     emit(LoadControllerEndWithErrorState());
  //   });
  // }

  // void disposeController({
  //   required VideoPlayerController? videoPlayerController,
  // }) {
  //   print('dispose controller');
  //   videoPlayerController?.pause();
  //   videoPlayerController?.dispose();
  //   videoPlayerController = null;
  // }

  void pauseVideo(VideoPlayerController videoPlayerController) {
    videoPlayerController.pause();
  }

  void playVideo(VideoPlayerController videoPlayerController) {
    videoPlayerController.play();
  }

  void newState() {
    emit(NewState());
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
