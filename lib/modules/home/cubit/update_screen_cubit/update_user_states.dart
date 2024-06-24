abstract class UpdateStates {}

class UpdateInitialState extends UpdateStates {}

class UpdateUserDataLoadingState extends UpdateStates {}

class UpdateUserDataSuccessState extends UpdateStates {
  String? message;
  UpdateUserDataSuccessState(this.message);
}

class UpdateUserDataErrorState extends UpdateStates {}

class ImageUploadedSuccessfullyState extends UpdateStates {}

class ImageUploadErrorState extends UpdateStates {}
