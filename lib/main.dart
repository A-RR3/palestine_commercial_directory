import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palestine_commercial_directory/core/localization/localization_settings.dart';
import 'package:palestine_commercial_directory/modules/splash/splash_screen.dart';
import 'package:palestine_commercial_directory/shared/network/remote/dio_helper.dart';
import 'package:palestine_commercial_directory/permission_cubit/permission_cubit.dart';
import 'package:palestine_commercial_directory/shared/network/remote/my_bloc_observer.dart';

import 'core/presentation/theme.dart';
import 'core/values/cache_keys.dart';
import 'core/values/constants.dart';
import 'modules/admin/cubit/admin_cubit.dart';
import 'shared/network/local/cache_helper.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  userToken = CacheHelper.getData(CacheKeys.token.name);
  userId = CacheHelper.getData(CacheKeys.userId.name);

  Locale startLocale = Locale(CacheHelper.getData(CacheKeys.lang.name) ??
      LocalizationSettings.defaultLanguage);

  runApp(EasyLocalization(
    supportedLocales: LocalizationSettings.localesList,
    path: 'assets/lang',
    fallbackLocale: LocalizationSettings.defaultLocale,
    startLocale: startLocale,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    appLocale = context.locale;
    CacheHelper.setData(
        key: CacheKeys.lang.name, value: context.locale.toString());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PermissionsCubit(),
        ),
        BlocProvider(
          create: (context) => AdminCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        darkTheme: darkTheme,
        theme: lightTheme,
        themeMode: ThemeMode.light,
        home: const SplashScreen(),
      ),
    );
  }
}
