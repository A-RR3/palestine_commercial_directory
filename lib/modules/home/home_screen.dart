import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:videos_application/core/utils/navigation_services.dart';
import 'package:videos_application/core/values/lang_keys.dart';
import 'package:videos_application/modules/auth/login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LangKeys.APP_NAME.tr()),
        actions: [
          TextButton(
              onPressed: () {
                NavigationServices.navigateTo(context, LoginScreen());
              },
              child: Text(LangKeys.LOGIN.tr())),
        ],
      ),
      body: const SafeArea(child: Placeholder()),
    );
  }
}
