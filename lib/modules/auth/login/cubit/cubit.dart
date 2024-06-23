import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/modules/auth/login/cubit/states.dart';
import '../../../../core/utils/mixins/password_mixin.dart';
import '../../../../models/login_model.dart';
import '../../../../models/test_data_model.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../shared/network/remote/end_points.dart';

class LoginCubit extends Cubit<LoginStates>
    with PasswordVisibilityMixin<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  List data = [
    TestDataModel(id: 2, phone: '0599887766', password: '12345'),
    TestDataModel(id: 18, phone: '0592637611', password: '12345')
  ];

  void selectUser(int id) {
    switch (id) {
      case 2:
        userPhoneController.text = data[0].phone;
        passwordController.text = data[0].password;
        break;
      case 18:
        userPhoneController.text = data[1].phone;
        passwordController.text = data[1].password;
        break;
    }
    emit(SelectUserTestDataState());
  }

  FocusNode phoneFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isBottonDisabled = false;

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

  // VoidCallback? isLogInButtonDisabled(BuildContext context) {
  //   return
  // }

  @override
  Future<void> close() {
    phoneFocus.dispose();
    passwordFocus.dispose();
    passwordController.dispose();
    userPhoneController.dispose();
    return super.close();
  }
}
