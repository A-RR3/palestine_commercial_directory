import 'package:videos_application/models/user_model.dart';

abstract class AdminStates {}

class InitialAdminState extends AdminStates {}

class UsersLoadingState extends AdminStates {}

class UsersSuccessState extends AdminStates {
  UserModel userModel;
  UsersSuccessState(this.userModel);
}

class UsersErrorState extends AdminStates {}
