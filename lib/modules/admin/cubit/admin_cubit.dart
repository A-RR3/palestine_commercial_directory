import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/models/user_model.dart';
import 'package:videos_application/modules/admin/cubit/states.dart';
import 'package:videos_application/modules/admin/screens/companies_screen.dart';
import 'package:videos_application/modules/admin/screens/users_screen.dart';
import '../../../core/values/constants.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(InitialAdminState());

  static AdminCubit get(context) => BlocProvider.of(context);

  List screens = [const UsersScreen(), const CompaniesScreen()];

  late UserModel userModel;

  void getUsersData() {
    emit(UsersLoadingState());
    DioHelper.getData(url: USERS, token: userToken).then((response) {
      userModel = UserModel?.fromJson(response?.data);
      emit(UsersSuccessState(userModel));
    }).catchError((error) {
      emit(UsersErrorState());
    });
  }
}
