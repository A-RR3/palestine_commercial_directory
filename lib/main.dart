import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/core/localization/localization_settings.dart';
import 'package:videos_application/modules/auth/login/login_screen.dart';
import 'package:videos_application/permission_cubit/permission_cubit.dart';
import 'package:videos_application/shared/network/remote/my_bloc_observer.dart';

import 'core/presentation/theme.dart';
import 'core/values/cache_keys.dart';
import 'core/values/constants.dart';
import 'modules/admin/cubit/admin_cubit.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  userLocale = Locale(LocalizationSettings.defaultLanguage);
  CacheHelper.setData(
    key: CacheKeys.lang.name,
    value: enCode,
  );

  runApp(EasyLocalization(
    supportedLocales: LocalizationSettings.localesList,
    path: 'assets/lang',
    fallbackLocale: LocalizationSettings.defaultLocale,
    startLocale: LocalizationSettings.defaultLocale,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PermissionsCubit(),
        ),
        BlocProvider(
          create: (context) => AdminCubit()..getUsersData(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        darkTheme: darkTheme,
        theme: lightTheme,
        themeMode: ThemeMode.light,
        home: LoginScreen(),
      ),
    );
  }
}
