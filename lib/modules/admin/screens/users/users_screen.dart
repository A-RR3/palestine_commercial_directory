import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palestine_commercial_directory/core/values/cache_keys.dart';
import 'package:palestine_commercial_directory/core/values/constants.dart';
import 'package:palestine_commercial_directory/modules/admin/screens/users/cubit/scroll_cubit.dart';
import 'package:palestine_commercial_directory/modules/admin/screens/users/cubit/users_cubit.dart';
import 'package:palestine_commercial_directory/modules/admin/widgets/users_list.dart';
import 'package:palestine_commercial_directory/shared/widgets/custom_text_widget.dart';
import '../../../../core/values/lang_keys.dart';
import '../../../../shared/widgets/my_search_bar.dart';
import 'cubit/states.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => UsersCubit()
                ..getUsersData('')
                ..getUsersData('', isActiveList: false)),
          BlocProvider(create: (context) => ScrollCubit())
        ],
        child: BlocConsumer<UsersCubit, UsersStates>(
          listener: (context, state) {
            if (state is ChangeUserStatusSuccessState) {
              showToast(meg: state.message, toastState: ToastStates.success);
            }
          },
          builder: (context, state) {
            UsersCubit usersCubit = UsersCubit.get(context);

            return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  flexibleSpace: appBarGradient,
                  elevation: 5,
                  centerTitle: true,
                  bottom: TabBar(
                      onTap: (value) {
                        usersCubit.isActiveList = (value == 0) ? true : false;
                      },
                      tabs: [
                        getTap(LangKeys.ACTIVE.tr()),
                        getTap(LangKeys.NON_ACTIVE.tr())
                      ]),
                  actions: [
                    MySearchBar(
                      hint: LangKeys.SEARCH.tr(),
                      onChanged: (value) {
                        usersCubit.cancelRequestToken();
                        usersCubit.refreshPagination();
                        usersCubit.isActiveList
                            ? usersCubit.getUsersData(value, isSearch: true)
                            : usersCubit.getUsersData(value,
                                isSearch: true, isActiveList: false);
                      },
                    ),
                  ],
                ),
                body: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TabBarView(children: [
                            (usersCubit.isActiveUsersLoading)
                                ? const SizedBox()
                                : (usersCubit.activeUsers.isEmpty)
                                    ? noUsersFoundWidget
                                    : ListViewWithController(
                                        isActiveList: true,
                                      ),
                            (usersCubit.isNonActiveUsersLoading)
                                ? const SizedBox()
                                : (usersCubit.archivedUsers.isEmpty)
                                    ? noUsersFoundWidget
                                    : ListViewWithController(
                                        isActiveList: false,
                                      ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }

  Widget get noUsersFoundWidget => Align(
        alignment: Alignment.topCenter,
        child: Text(LangKeys.NoUsersFound.tr()),
      );

  Widget getTap(String title) => Tab(
        child: DefaultText(
          text: title,
        ),
      );
}
