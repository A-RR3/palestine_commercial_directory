import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:videos_application/demo_data.dart';
import 'package:videos_application/models/video_models/data_model.dart';
import 'package:videos_application/modules/videos_modules/videos_cubit/videos_states.dart';

import '../../../models/video_models/video_model.dart';

class VideosCubit extends Cubit<VideosStates> {
  VideosCubit() : super(VideosInitialState());

  static VideosCubit get(context) => BlocProvider.of(context);

  // GetVideosModel? getVideosModel;
  DataModel? dataModel;

  // VideoModel? videoModel;

  void getVideosData() {
    emit(GetVideosLoadingState());
    // getVideosModel = GetVideosModel.fromMap(data);
    // videoModel = VideoModel.fromMap(data.first);
    dataModel = DataModel.fromMap(dataObj);
    print(dataModel!.toMap());
    emit(GetVideosSuccessState());
  }

  Future<void> loadController({
    required VideoModel videoModel,
    required Function(VideoPlayerController?) onControllerLoaded,
  }) async {
    print('load controller');
    emit(LoadControllerStartState());
    try {
      VideoPlayerController controller =
          VideoPlayerController.networkUrl(Uri.parse(videoModel.url!));
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
