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
  List<User> users = [];
  int page = 1;
  int perPage = 7;
  bool hasMore = true;
  bool isLastPage = false;

  void fetchIfHasData(void callback) {
    hasMore ? callback : null;
  }

  late UserModel userModel;

  void getUsersData() {
    emit(UsersLoadingState());
    DioHelper.getData(
        url: USERS,
        token: userToken,
        query: {"per_page": perPage, "page": page}).then((response) {
      userModel = UserModel?.fromJson(response?.data);
      page++;
      users.addAll(userModel.users!);
      if (userModel.pagination!.currentPage ==
          userModel.pagination!.lastPage) {
        isLastPage = true;
        hasMore = false;
      }
      emit(UsersSuccessState(userModel));
    }).catchError((error) {
      emit(UsersErrorState());
    });
  }
}
