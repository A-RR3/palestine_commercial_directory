import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palestine_commercial_directory/core/values/constants.dart';
import 'package:palestine_commercial_directory/modules/auth/login/cubit/states.dart';
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
    TestDataModel(id: 2, phone: '0592637688', password: '12345'),
    TestDataModel(id: 18, phone: '0599887766', password: '12345')
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

  Future<void> saveDeviceToken({
    required int uId,
  }) async {
    emit(SaveDeviceTokenInitialState());
    print(deviceToken);
    await DioHelper.postData(url: EndPointsConstants.saveDeviceToken, data: {
      'd_user_id': userId,
      'device_token': deviceToken,
    }).then((value) {
      print(value);
      emit(SaveDeviceTokenSuccessState());
    }).catchError((error) {
      emit(SaveDeviceTokenErrorState());
    });
  }

  Future<void> removeDeviceToken({
    required int uId,
  }) async {
    emit(RemoveDeviceTokenInitialState());
    print(deviceToken);
    await DioHelper.deleteData(
        url: EndPointsConstants.removeDeviceToken,
        data: {
          'd_user_id': userId,
          'device_token': deviceToken,
        }).then((value) {
      print(value?.data);
      emit(RemoveDeviceTokenSuccessState());
    }).catchError((error) {
      emit(RemoveDeviceTokenErrorState());
    });
  }

  @override
  Future<void> close() {
    phoneFocus.dispose();
    passwordFocus.dispose();
    passwordController.dispose();
    userPhoneController.dispose();
    return super.close();
  }
}
