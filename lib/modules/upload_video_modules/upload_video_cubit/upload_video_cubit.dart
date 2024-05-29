import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:videos_application/modules/upload_video_modules/upload_video_cubit/upload_video_states.dart';

// may convert to mixin

class UploadVideoCubit extends Cubit<UploadVideoStates>{
  UploadVideoCubit() : super(UploadVideoInitialState());

  static UploadVideoCubit get(context) => BlocProvider.of(context);

  final ImagePicker picker = ImagePicker();
  XFile? video;

  Future<void> pickVideo() async {
    try {
      video = await picker.pickVideo(source: ImageSource.gallery);
      if (video != null) {
        print('success');
      } else {
        print('no video selected');
      }
    } catch (e) {
      print('failed');
    }
  }
}