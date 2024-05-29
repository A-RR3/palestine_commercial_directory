import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:videos_application/demo_data.dart';
import 'package:videos_application/models/get_videos_model.dart';
import 'package:videos_application/models/video_model.dart';
import 'package:videos_application/modules/videos_modules/videos_cubit/videos_states.dart';

class VideosCubit extends Cubit<VideosStates> {
  VideosCubit() : super(VideosInitialState());

  static VideosCubit get(context) => BlocProvider.of(context);

  GetVideosModel? getVideosModel;
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

  // send model (that contains controller)
  void loadController({required VideoModel videoModel}) async {
    emit(LoadControllerStartState());
    await videoModel.loadController();
    emit(LoadControllerEndState());
  }

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
