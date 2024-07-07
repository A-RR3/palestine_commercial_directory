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

class ChangeLoginButtonDisabledState extends LoginStates {}

class SelectUserTestDataState extends LoginStates {}

class SaveDeviceTokenInitialState extends LoginStates {}

class SaveDeviceTokenSuccessState extends LoginStates {}

class SaveDeviceTokenErrorState extends LoginStates {}

class RemoveDeviceTokenInitialState extends LoginStates {}

class RemoveDeviceTokenSuccessState extends LoginStates {}

class RemoveDeviceTokenErrorState extends LoginStates {}
