import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:videos_application/core/utils/navigation_services.dart';
import 'package:videos_application/core/values/cache_keys.dart';
import 'package:videos_application/core/values/lang_keys.dart';
import 'package:videos_application/modules/admin/admin_screen.dart';
import 'package:videos_application/modules/auth/login/login_screen.dart';
import 'package:videos_application/modules/home/owner_view.dart';
import 'package:videos_application/modules/splash/splash_screen.dart';

import '../../core/values/constants.dart';
import '../../shared/network/local/cache_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(LangKeys.APP_NAME.tr()),
          actions: [
            isLogged
                ? TextButton(
                    onPressed: () async {
                      await CacheHelper.removeData(CacheKeys.token.name);
                      await CacheHelper.removeData(CacheKeys.isLogged.name);
                      await CacheHelper.removeData(CacheKeys.userRole.name);
                      await CacheHelper.removeData(CacheKeys.userId.name);
                      // NavigationServices.navigateTo(context, LoginScreen(),
                      //     removeAll: true);
                    },
                    child: Text(LangKeys.LOGOUT.tr()))
                : TextButton(
                    onPressed: () {
                      NavigationServices.navigateTo(context, LoginScreen());
                    },
                    child: Text(LangKeys.LOGIN.tr()))
          ],
        ),
        body: !isLogged
            ? Text('home screen')
            : userRole == 1
                ? AdminPanel()
                : CompanyOwnerView(
                    userId: userId,
                  ));
  }
}
