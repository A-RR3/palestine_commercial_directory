import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_compress/video_compress.dart';

mixin CompressVideoMixin<T> on Cubit<T> {
  MediaInfo? mediaInfo;

  Future<void> compressVideo(String filePath) async {
    // emit(VideoCompressionLoading());
    try {
      print('original file path: ${filePath}');
      mediaInfo = await VideoCompress.compressVideo(
        filePath,
        quality: VideoQuality.MediumQuality,
        deleteOrigin: false,
      );
      print('final path after compress: ${mediaInfo?.path}');
      // emit(VideoCompressionSuccess(mediaInfo?.path ?? ''));
    } catch (e) {
      // emit(VideoCompressionFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    // VideoCompress.dispose();
    return super.close();
  }
}
