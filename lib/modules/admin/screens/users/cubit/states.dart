import 'package:videos_application/models/user_model.dart';

abstract class UsersStates {}

class SearchInitialState extends UsersStates {}

class SearchLoadingState extends UsersStates {}

class SearchSuccessState extends UsersStates {}

class SearchErrorState extends UsersStates {}

class NonActiveUsersLoadingState extends UsersStates {}

class ActiveUsersLoadingState extends UsersStates {}

class GetUsersSuccessState extends UsersStates {
  // UserModel userModel;
  // GetUsersSuccessState(this.userModel);
}

class GetArchivedUsersSuccessState extends UsersStates {}

class GetUsersErrorState extends UsersStates {}

class GetArchivedUsersLoadingState extends UsersStates {}

class GetArchivedGetUsersSuccessState extends UsersStates {
  UserModel model;
  GetArchivedGetUsersSuccessState(this.model);
}

class GetArchivedGetUsersErrorState extends UsersStates {}

class ChangeUserStatusLoadingState extends UsersStates {}

class ChangeUserStatusSuccessState extends UsersStates {
  String message;

  ChangeUserStatusSuccessState(this.message);
}

class ChangeUserStatusErrorState extends UsersStates {}

class OnClickArchiveButtonState extends UsersStates {}
