import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palestine_commercial_directory/core/utils/mixins/cancel_token_mixin.dart';
import 'package:palestine_commercial_directory/modules/admin/screens/users/cubit/states.dart';
import '../../../../../core/values/constants.dart';
import '../../../../../models/user_model.dart';
import '../../../../../shared/network/remote/dio_helper.dart';
import '../../../../../shared/network/remote/end_points.dart';

class UsersCubit extends Cubit<UsersStates> with CancelTokenMixin {
  UsersCubit() : super(SearchInitialState());

  static UsersCubit get(context) => BlocProvider.of(context);

  List<User>? searchList;
  List<User> activeUsers = [];
  List<User> archivedUsers = [];
  bool isActiveList = true;

  //pagination variables
  bool activeListHasMore = true;
  bool archivedListHasMore = true;
  bool isActiveLastPage = false;
  bool isArchivedLastPage = false;
  int activePageNumber = 1;
  int archivedPageNumber = 1;
  int perPage = 8;
  bool isActiveUsersLoading = false;
  bool isNonActiveUsersLoading = false;

  UserModel? archivedUsersModel;
  UserModel? activeUsersModel;

  bool localListsUpdated = false;

  // @override
  // Future<void> close() {
  //   activeUsersModel = null;
  //   archivedUsersModel = null;
  //   return super.close();
  // }

  void fetchIfHasData({bool isActiveList = true}) async {
    print('localListsUpdated$localListsUpdated');
    isActiveList
        ? activeListHasMore
            ? await getUsersData('')
            // {
            //             localListsUpdated
            //                 ? await getUsersData('', isSearch: true)
            //                 : await getUsersData('')
            //           }
            : null
        : archivedListHasMore
            ? await getUsersData('', isActiveList: false)
            // localListsUpdated
            //             ? await getUsersData('', isSearch: true, isActiveList: false)
            //             : await getUsersData('', isActiveList: false)
            : null;
  }

  void refreshPagination() {
    activePageNumber = 1;
    archivedPageNumber = 1;
  }

  Future<void> getUsersData(String? text,
      {bool isSearch = false, bool isActiveList = true}) async {
    isActiveList
        ? {isActiveUsersLoading = true, emit(ActiveUsersLoadingState())}
        : {isNonActiveUsersLoading = true, emit(NonActiveUsersLoadingState())};

    int status = isActiveList ? 1 : 0;

    if (isSearch) {
      isActiveList ? activeUsers = [] : archivedUsers = [];
    }

    await DioHelper.getData(
            url: USERS,
            token: userToken,
            query: {
              "per_page": perPage,
              "page": isActiveList ? activePageNumber : archivedPageNumber,
              "status": status,
            },
            data: {"text": text},
            cancelToken: cancelToken)
        .then((response) {
      if (isActiveList) {
        print('in active');
        var data = response?.data;
        activeUsersModel = UserModel.fromJson(data);
        renderActiveList();
        print('reached');
        isActiveUsersLoading = false;
        emit(GetUsersSuccessState());
      } else {
        print('in archive');
        archivedUsersModel = UserModel.fromJson(response?.data);
        renderArchivedList();
        print('reached');

        isNonActiveUsersLoading = false;
        emit(GetArchivedUsersSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(GetUsersErrorState());
    });
  }

  void renderActiveList() {
    print('inn');
    activePageNumber++;
    activeUsers.addAll(activeUsersModel!.users!);
    if (activeUsersModel!.pagination!.currentPage ==
        activeUsersModel!.pagination!.lastPage) {
      isActiveLastPage = true;
      activeListHasMore = false;
    } else {
      activeListHasMore = true;
      isActiveLastPage = false;
    }
  }

  void renderArchivedList() {
    archivedPageNumber++;
    archivedUsers.addAll(archivedUsersModel!.users!);
    if (archivedUsersModel!.pagination!.currentPage ==
        archivedUsersModel!.pagination!.lastPage) {
      isArchivedLastPage = true;
      archivedListHasMore = false;
    } else {
      archivedListHasMore = true;
      isArchivedLastPage = false;
    }
  }

  void changeUserStatus(int id, int index, {bool isActive = true}) async {
    emit(ChangeUserStatusLoadingState());
    await DioHelper.postData(
      url: '$USERS/$id',
      token: userToken,
    ).then((response) async {
      String? message = response?.data["message"];
      await refreshListsAfterStatusChange(isActive, id, index);
      emit(ChangeUserStatusSuccessState(message!));
    }).catchError((error) {
      print(error.toString());
      emit(ChangeUserStatusErrorState());
    });
  }

  Future<void> refreshListsAfterStatusChange(
      bool isActiveList, int userId, int index) async {
    refreshPagination();
    await getUsersData('', isSearch: true); //is search will empty the lists
    await getUsersData('', isActiveList: false, isSearch: true);
    // if (isActiveList) {
    //   User deactivatedUser = activeUsers
    //       .where(
    //         (user) => user.uId == userId,
    //       )
    //       .first;
    //   activeUsers.removeAt(index);
    //   archivedUsers.add(deactivatedUser);
    //   print('archivedUsers${archivedUsers.last.uName}');
    // } else {
    //   User activatedUser = archivedUsers
    //       .where(
    //         (user) => user.uId == userId,
    //       )
    //       .first;
    //   archivedUsers.removeAt(index);
    //   activeUsers.add(activatedUser);
    //   print('activatedUser${activeUsers.last.uName}');
    // }
  }
}
