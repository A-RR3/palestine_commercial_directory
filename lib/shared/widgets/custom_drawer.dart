import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:videos_application/core/utils/navigation_services.dart';
import 'package:videos_application/core/values/cache_keys.dart';
import 'package:videos_application/core/values/constants.dart';
import 'package:videos_application/modules/home/screens/update_user_data_screen.dart';
import 'package:videos_application/modules/home/widgets/app_drawer_tile.dart';
import 'package:videos_application/shared/network/local/cache_helper.dart';
import 'package:videos_application/shared/widgets/custom_text_widget.dart';

import '../../core/values/asset_keys.dart';
import '../../modules/home/cubit/home_cubit.dart';
import '../network/remote/end_points.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.cubit});
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    bool isLogged = CacheHelper.getBool(CacheKeys.isLogged.name);
    bool isEnglish = CacheHelper.getData(CacheKeys.lang.name) == enCode;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: appGradient,
                  image: DecorationImage(
                      image: AssetImage(
                          AssetsKeys.getImagePath(AssetsKeys.PINK_PILLOW)),
                      fit: BoxFit.cover)),
              padding: const EdgeInsets.all(20),
              child: isLogged
                  ? Row(
                      children: [
                        cubit.user?.uImage != null
                            ? defaultContainer(
                                width: 90,
                                height: 90,
                                child: ClipOval(
                                    child: Image.network(
                                  '${EndPointsConstants.usersStorage}${cubit.user?.uImage}',
                                  fit: BoxFit.cover,
                                )),
                              )
                            : defaultContainer(
                                child: defaultPersonImage, hasShadow: true),
                        hSpace(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DefaultText(
                                  text: isEnglish
                                      ? cubit.user!.uName!
                                      : cubit.user!.uNameAr!),
                              vSpace(5),
                              GestureDetector(
                                  onTap: () {
                                    NavigationServices.navigateTo(
                                        context,
                                        UpdateUserDataScreen(
                                          homeCubit: cubit,
                                        ));
                                  },
                                  child: SvgPicture.asset(
                                    AssetsKeys.getIconPath(
                                        AssetsKeys.EDIT_ICON),
                                    width: 20,
                                    height: 20,
                                  ))
                            ],
                          ),
                        )
                      ],
                    )
                  : const SizedBox()),
          AppDrawerTile(
            index: 0,
            onTap: () {
              cubit.changeSelectedIndex(0);
              cubit.changeAppLanguage(context);
              NavigationServices.back(context);
            },
          ),
          AppDrawerTile(
            index: 1,
            onTap: () {
              cubit.changeSelectedIndex(1);
              cubit.changeAppLanguage(context);
              NavigationServices.back(context);
            },
          ),
          isLogged
              ? AppDrawerTile(
                  index: 2,
                  onTap: () {
                    cubit.changeSelectedIndex(2);
                    cubit.logoutUser(context);
                  },
                )
              : hSpace()
        ],
      ),
    );
  }
}
