import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/core/localization/localization_settings.dart';
import 'package:videos_application/shared/network/remote/my_bloc_observer.dart';
import 'package:videos_application/permission_cubit/permission_cubit.dart';
import 'core/presentation/theme.dart';
import 'modules/auth/login/login_screen.dart';
import 'modules/home/home_screen.dart';
import 'modules/splash/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? true;
  String? token = CacheHelper.getData(key: 'token');
  Widget startScreen = onBoarding
      ? const SplashScreen()
      : token == null
          ? const LoginScreen()
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
   const MyApp({super.key, this.startScreen});
  final Widget? startScreen;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PermissionsCubit(),
        ),
      ],
      child: MaterialApp(
        locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      darkTheme: darkTheme,
      theme: lightTheme,
      themeMode: ThemeMode.light,
      home: const SplashScreen(),
      ),
    );
  }
}
