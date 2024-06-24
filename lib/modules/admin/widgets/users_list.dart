import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:videos_application/core/presentation/Palette.dart';
import 'package:videos_application/core/utils/extensions.dart';
import 'package:videos_application/core/values/asset_keys.dart';
import 'package:videos_application/core/values/constants.dart';
import 'package:videos_application/modules/admin/screens/users/cubit/states.dart';
import 'package:videos_application/shared/network/remote/end_points.dart';
import 'package:videos_application/shared/widgets/custom_text_widget.dart';
import 'package:videos_application/shared/widgets/my_search_bar.dart';
import '../../../core/values/cache_keys.dart';
import '../../../core/values/lang_keys.dart';
import '../../../models/user_model.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../screens/users/cubit/scroll_cubit.dart';
import '../screens/users/cubit/users_cubit.dart';

class ListViewWithController extends StatefulWidget {
  bool isActiveList;

  ListViewWithController({super.key, required this.isActiveList});

  @override
  State<ListViewWithController> createState() => _ListViewWithControllerState();
}

class _ListViewWithControllerState extends State<ListViewWithController> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersCubit, UsersStates>(
      listener: (context, state) {},
      builder: (context, state) {
        UsersCubit usersCubit = UsersCubit.get(context);
        // List users = isActiveList ? cubit.activeUsers : cubit.archivedUsers;
        // print('last: ${users.indexOf(users[users.length - 1])}');

        return BlocConsumer<ScrollCubit, bool>(
          listener: (context, scrollState) {
            if (scrollState) {
              widget.isActiveList
                  ? usersCubit.fetchIfHasData()
                  : usersCubit.fetchIfHasData(isActiveList: false);
            }
          },
          builder: (context, scrollState) {
            ScrollCubit scrollCubit = ScrollCubit.get(context);
            return Column(
              children: [
                if (state is ChangeUserStatusLoadingState ||
                    usersCubit.isActiveUsersLoading ||
                    usersCubit.isNonActiveUsersLoading)
                  LinearProgressIndicator(),
                Expanded(
                    child: ListView.builder(
                        controller: scrollCubit.scrollController,
                        itemBuilder: (context, index) {
                          print(
                              'cubit.isLastPage ${widget.isActiveList ? usersCubit.isActiveLastPage : usersCubit.isArchivedLastPage}');
                          print(
                              'widget.cubit.hasmore ${widget.isActiveList ? usersCubit.activeListHasMore : usersCubit.archivedListHasMore}');

                          int listSize = widget.isActiveList
                              ? usersCubit.activeUsers.length
                              : usersCubit.archivedUsers.length;
                          print('listSize ${listSize}');

                          // if (index == listSize - 1) {
                          //   return Text('data');
                          // }
                          if (index <
                              (widget.isActiveList
                                  ? usersCubit.activeUsers.length
                                  : usersCubit.archivedUsers.length)) {
                            print(index);
                            User user = widget.isActiveList
                                ? usersCubit.activeUsers[index]
                                : usersCubit.archivedUsers[index];
                            return Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: boxShadow,
                                          borderRadius:
                                              BorderRadius.circular(35),
                                        ),
                                        padding: EdgeInsets.only(top: 30),
                                      ),
                                    ),
                                    UserListTileWidget(
                                        usersCubit, user, context, index)
                                  ],
                                ));
                          } else {
                            return (widget.isActiveList
                                    ? usersCubit.activeListHasMore
                                    : usersCubit.archivedListHasMore)
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : vSpace();
                          }
                        },
                        itemCount: (widget.isActiveList
                                ? usersCubit.activeUsers.length
                                : usersCubit.archivedUsers.length) +
                            ((widget.isActiveList
                                    ? usersCubit.isActiveLastPage
                                    : usersCubit.isArchivedLastPage)
                                ? 0
                                : 1)))
              ],
            );
          },
        );
      },
    );
  }

  bool isEnglish = CacheHelper.getData(CacheKeys.lang.name) == enCode;

  ListTile UserListTileWidget(
      UsersCubit cubit, User user, BuildContext context, int index) {
    return ListTile(
      title: DefaultText(
        text: isEnglish ? user.uName! : user.uNameAr!,
        color: Colors.black,
      ),
      subtitle: DefaultText(
        text: LangKeys.COMPANIES_COUNT.tr(namedArgs: {
          'number': '${user.companiesCount!}',
        }),
        style: context.textTheme.bodySmall!
            .copyWith(color: Palette.adminPageIconsColor),
      ),
      leading: user.uImage != null
          ? Container(
              width: 60,
              height: 70,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(40)),
              child: ClipOval(
                  child: Image.network(
                '${EndPointsConstants.usersStorage}${user.uImage}',
                fit: BoxFit.cover,
              )),
            )
          : defaultPersonImage,
      onTap: () {
        FocusScope.of(context).unfocus();
        Future.delayed(
          Duration(milliseconds: 700),
          () => dialogScreen(context, user),
        );
      },
      minTileHeight: 80,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
      trailing: IconButton(
          onPressed: () {
            widget.isActiveList
                ? confirmationDialog(context, widget.isActiveList,
                    () => cubit.changeUserStatus(user.uId!, index))
                : confirmationDialog(
                    context,
                    widget.isActiveList,
                    () => cubit.changeUserStatus(user.uId!, index,
                        isActive: false));
          },
          icon: widget.isActiveList
              ? Icon(
                  Icons.delete,
                  color: Colors.red,
                )
              : Icon(
                  Icons.delete_forever_outlined,
                  color: widget.isActiveList ? Colors.red : Colors.green,
                )),
    );
  }

  confirmationDialog(
      BuildContext context, bool isActivate, Function callBackFunc) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: isActivate
              ? Text('Confirm Activation')
              : Text('Confirm Deactivation'),
          content: isActivate
              ? Text('Are you sure you want to activate this user?')
              : Text('Are you sure you want to deactivate this user?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
                callBackFunc(); // Perform the delete action
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  dialogScreen(BuildContext context, User user) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11.0),
          ),
          elevation: 8,
          backgroundColor: const Color(0xffEDF8F9),
          insetPadding: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LangKeys.USER_COMPANIES
                        .tr(namedArgs: {'companies': '${user.companiesCount}'}),
                    style: context.textTheme.headlineSmall,
                  ),
                  vSpace(),
                  const Divider(
                    thickness: 1.5,
                  ),
                  vSpace(),
                  SizedBox(
                      height: context.deviceSize.height * .5,
                      width: context.deviceSize.width * .7,
                      child: Center(
                          child: ListView.separated(
                              itemBuilder: (context, companyIndex) {
                                return Text(
                                  user.companies![companyIndex].cName!,
                                  style: context.textTheme.bodyLarge,
                                );
                              },
                              separatorBuilder: (context, index) => myDivider,
                              itemCount: user.companiesCount!))),
                ]),
          ),
        );
      },
    );
  }
}
