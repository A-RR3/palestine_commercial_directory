import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:palestine_commercial_directory/core/localization/localization_settings.dart';
import 'package:palestine_commercial_directory/core/utils/helper_notification.dart';
import 'package:palestine_commercial_directory/modules/splash/splash_screen.dart';
import 'package:palestine_commercial_directory/shared/network/remote/dio_helper.dart';
import 'package:palestine_commercial_directory/permission_cubit/permission_cubit.dart';
import 'package:palestine_commercial_directory/shared/network/remote/my_bloc_observer.dart';
import 'core/presentation/theme.dart';
import 'core/values/cache_keys.dart';
import 'core/values/constants.dart';
import 'modules/admin/cubit/admin_cubit.dart';
import 'shared/network/local/cache_helper.dart';
// import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();

  print(
      "Handling a background message: ${message.messageId}" //0:1719745156185396%d218f6d3d218f6d3
      "/${message.notification?.title}"
      "/${message.notification?.body}"
      "/${message.notification?.bodyLocKey}"); //null
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAHTPO-b4jQ3Py_SD9jZRm4EoebsUSpUiQ',
          appId: '1:423185378538:android:12d787f9f0a02211437b93',
          messagingSenderId: '423185378538',
          projectId: 'todo-firebase-a1916'));

  // requestNotificationPermission();

  FirebaseMessaging.instance.setAutoInitEnabled(false);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Got a message whilst in the foreground!');
  //   print(
  //       'Message data: ${message.data}/${message.senderId}/${message.notification?.title}/${message.notification?.body}');
  //   // Message data: {}/null/Palcom /new company is registered !
  //   if (message.notification != null) {
  //     print(
  //         'Message also contained a notification: ${message.notification}'); //Instance of 'RemoteNotification'
  //   }
  // });

  await HelperNotification.initialize(flutterLocalNotificationsPlugin);
  DioHelper.init();

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();
  // CacheHelper.setData(value: false, key: CacheKeys.isLogged.name);
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
        navigatorKey: navigatorKey,
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
