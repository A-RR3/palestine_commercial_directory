import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:videos_application/models/video_models/upload_video_model.dart';
import 'package:videos_application/modules/upload_video_modules/upload_video_cubit/upload_video_states.dart';
import 'package:videos_application/shared/network/remote/dio_helper.dart';
import 'package:videos_application/shared/network/remote/end_points.dart';

// may convert to mixin

class UploadVideoCubit extends Cubit<UploadVideoStates> {
  UploadVideoCubit() : super(UploadVideoInitialState());

  static UploadVideoCubit get(context) => BlocProvider.of(context);

  // UploadVideoSuccessState
  // UploadVideoErrorState

  GlobalKey<FormState> addPostFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  // video
  // user_id

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

  UploadVideoModel? uploadVideoModel;

  Future<void> addVideo(
      {File? videoFile, required String title, required String content}) async {
    emit(UploadVideoLoadingState());
    FormData formData = FormData.fromMap({
      if (videoFile != null)
        'video': await MultipartFile.fromFile(videoFile.path),
      'title': title,
      'content': content,
      'user_id': 1,
    });
    DioHelper.postData(url: EndPointsConstants.post, data: formData)
        .then((value) {
      print(value?.data);
      uploadVideoModel = UploadVideoModel.fromMap(value?.data);
      emit(UploadVideoSuccessState(uploadVideoModel: uploadVideoModel!));
    }).catchError((error) {
      emit(UploadVideoErrorState(error: error.toString()));
      print(error.toString());
    });
  }
}
