import 'package:palestine_commercial_directory/models/video_models/upload_video_model.dart';

abstract class UploadVideoStates {}

class UploadVideoInitialState extends UploadVideoStates {}

class UploadVideoLoadingState extends UploadVideoStates {}

class UploadVideoSuccessState extends UploadVideoStates {
  final UploadVideoModel uploadVideoModel;

  UploadVideoSuccessState({required this.uploadVideoModel});
}

class UploadVideoErrorState extends UploadVideoStates {
  final String error;

  UploadVideoErrorState({required this.error});
}

class CompressVideoLoadingState extends UploadVideoStates {}

class CompressVideoSuccessState extends UploadVideoStates {}

class CompressVideoErrorState extends UploadVideoStates {
  final String error;

  CompressVideoErrorState({required this.error});
}
