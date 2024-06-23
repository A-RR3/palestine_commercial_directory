import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/core/values/constants.dart';
import 'package:videos_application/modules/admin/screens/users/cubit/users_cubit.dart';
import 'package:videos_application/modules/home/cubit/home_states.dart';
import '../../../../../core/utils/mixins/password_mixin.dart';
import '../../../../../shared/network/remote/dio_helper.dart';
import '../../../../../shared/network/remote/end_points.dart';
import '../../../core/utils/navigation_services.dart';
import '../../../core/values/cache_keys.dart';
import '../../../models/user_model.dart';
import '../../../shared/network/local/cache_helper.dart';

class HomeCubit extends Cubit<HomeStates>
    with PasswordVisibilityMixin<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int drawerSelectedIndex = 0;

  void changeSelectedIndex(int index) {
    drawerSelectedIndex = index;
    emit(ChangeDrawerSelectedIndex());
  }

  void logoutUser(BuildContext context) async {
    await CacheHelper.removeData(CacheKeys.token.name);
    await CacheHelper.setData(key: CacheKeys.isLogged.name, value: false);
    await CacheHelper.removeData(CacheKeys.userRole.name);
    await CacheHelper.removeData(CacheKeys.userId.name);
    await DioHelper.postData(url: LOGOUT, token: userToken).then((res) {
      Map data = res?.data;
      String message = data["message"];
      isLogged = false;
      user = null;
      NavigationServices.back(context);
      emit(UserLoggedOutSuccessfully(message));
    }).catchError((e) {
      emit(ErrorUserLoggedOut());
    });
  }

  void changeAppLanguage(BuildContext context) {
    emit(ChangeAppLangLoadingStateState());
    UsersCubit usersCubit = UsersCubit();
    appLocale = appLocale == const Locale('en')
        ? const Locale('ar')
        : const Locale('en');
    context.setLocale(appLocale!);
    CacheHelper.setData(
        key: CacheKeys.lang.name, value: context.locale.toString());
    if (user?.uId != null) {
      getSingleUserById(user?.uId);
    }
    emit(ChangeAppLangState());
  }

  User? user;
  void getSingleUserById(int? id) async {
    if (id == null) return;
    emit(GetCurrentUserDataInitialState());
    await DioHelper.getData(url: '$USERS/$id', token: userToken).then((res) {
      user = User.fromJson(res?.data['user']);
      print(user?.uName ?? 'empty user name');
      emit(GetCurrentUserDataSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(GetCurrentUserDataErrorState());
    });
  }
}
