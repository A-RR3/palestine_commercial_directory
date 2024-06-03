import '../../../../models/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel profileModel;
  LoginSuccessState(this.profileModel);
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

class ChangePasswordVisibilityState extends LoginStates {}
