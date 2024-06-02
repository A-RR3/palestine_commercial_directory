import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/modules/auth/login/cubit/states.dart';
import '../../../../core/utils/mixins/password_mixin.dart';
import '../../../../models/login_model.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../shared/network/remote/end_points.dart';

class LoginCubit extends Cubit<LoginStates>
    with PasswordVisibilityMixin<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  FocusNode phoneFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  void userLogin({
    required String phone,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'u_phone': phone,
      'password': password,
    }).then((value) {
      LoginModel loginModel = LoginModel.fromJson(value?.data);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  @override
  Future<void> close() {
    phoneFocus.dispose();
    passwordFocus.dispose();
    return super.close();
  }
}
