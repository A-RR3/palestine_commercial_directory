import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:palestine_commercial_directory/core/managers/theme_manager.dart';
import 'package:palestine_commercial_directory/shared/network/local/cache_helper.dart';
import 'package:palestine_commercial_directory/shared/network/remote/bloc_observer.dart';
import 'package:palestine_commercial_directory/shared/network/remote/dio_helper.dart';

import 'core/localization/localization_settings.dart';
import 'modules/home_screen/home_screen.dart';
import 'modules/login/login_screen.dart';
import 'modules/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? true;
  String? token = CacheHelper.getData(key: 'token');
  Widget startScreen = onBoarding
      ? const OnBoardingScreen()
      : token == null
          ? LoginScreen()
          : const HomeScreen();

  runApp(EasyLocalization(
    supportedLocales: LocalizationSettings.localesList,
    path: 'assets/lang',
    fallbackLocale: LocalizationSettings.defaultLocale,
    startLocale: LocalizationSettings.defaultLocale,
    child: MyApp(startScreen: startScreen),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, this.startScreen});
  final Widget? startScreen;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      darkTheme: darkTheme,
      theme: lightTheme,
      themeMode: ThemeMode.light,
      home: OnBoardingScreen(),
    );
  }
}
