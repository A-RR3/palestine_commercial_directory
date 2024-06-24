import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_compress/video_compress.dart';

import '../../../modules/upload_video_modules/upload_video_cubit/upload_video_states.dart';

mixin CompressVideoMixin<T> on Cubit<T> {
  MediaInfo? mediaInfo;

  Future<void> compressVideo(String filePath) async {
// <<<<<<< admin_panel_backup
//     // emit(VideoCompressionLoading());
//     try {
//       print('original file path: $filePath');
//       mediaInfo = await VideoCompress.compressVideo(
//         filePath,
//         quality: VideoQuality.MediumQuality,
//         deleteOrigin: false,
//       );
// =======
    emit(CompressVideoLoadingState() as T);
    print('original file path: ${filePath}');
    await VideoCompress.compressVideo(
      filePath,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: false,
    ).then((value) {
      mediaInfo = value;
// >>>>>>> main
      print('final path after compress: ${mediaInfo?.path}');
      emit(CompressVideoSuccessState() as T);
    }).catchError((error) {
      emit(CompressVideoErrorState(error: error.toString()) as T);
    });
  }

  @override
  Future<void> close() {
    VideoCompress.dispose();
    return super.close();
  }
}
