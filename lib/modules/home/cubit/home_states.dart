abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class UserLoggedOutSuccessfully extends HomeStates {
  String message;
  UserLoggedOutSuccessfully(this.message);
}

class ErrorUserLoggedOut extends HomeStates {}

class ChangeDrawerSelectedIndex extends HomeStates {}

class GetCurrentUserDataInitialState extends HomeStates {}

class GetCurrentUserDataSuccessState extends HomeStates {}

class GetCurrentUserDataErrorState extends HomeStates {}

class ChangeAppLangLoadingStateState extends HomeStates {}

class ChangeAppLangState extends HomeStates {}
