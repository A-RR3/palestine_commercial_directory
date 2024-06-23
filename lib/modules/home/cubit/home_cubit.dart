import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/core/values/constants.dart';
import 'package:videos_application/modules/auth/login/cubit/states.dart';
import '../../../../core/utils/mixins/password_mixin.dart';
import '../../../../models/login_model.dart';
import '../../../../shared/network/remote/dio_helper.dart';
import '../../../../shared/network/remote/end_points.dart';

class HomeCubit extends Cubit<LoginStates>
    with PasswordVisibilityMixin<LoginStates> {
  HomeCubit() : super(LoginInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  void logoutUser() {
    DioHelper.postData(url: LOGOUT, token: userToken);
  }
}
