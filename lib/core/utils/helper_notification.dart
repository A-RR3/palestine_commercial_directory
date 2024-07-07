import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:palestine_commercial_directory/core/values/constants.dart';
import 'package:palestine_commercial_directory/main.dart';
import 'package:palestine_commercial_directory/modules/home/home_screen.dart';

class HelperNotification {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    FirebaseMessaging.instance.requestPermission();
    // Request permission for iOS
    // NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // );
    // print('User granted permission: ${settings.authorizationStatus}');
    final fcmToken = await FirebaseMessaging.instance.getToken();
    deviceToken = fcmToken;

    print('message data: $fcmToken');

    // String? installationId = await FirebaseInstallations.;
    // print('FirebaseInstallationsId: $installationId');
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/notification_icon');
    // var iOSInitialize = new IOSInitializationSettings();
    var initializationSettings =
        InitializationSettings(android: androidInitialize);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (details) {
        print('onDidReceiveBackgroundNotificationResponse$details');
      },
      onDidReceiveNotificationResponse: (details) {
        print('onDidReceiveNotificationResponse: $details');
        //     (String? payload) async {
        //   try {
        //     if (payload != null && payload.isNotEmpty) {
        //       Get.toNamed(RouteHelper.getOrderDetailsRoute(int.parse(payload)));
        //     }
        //   } catch (e) {
        //     return;
        //   }
        // }
      },
    );

    //android app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('-----------onMessage-----------');
      print(
          'onMessage: ${message.notification?.title}/${message.notification?.body}/${message.notification?.titleLocKey}');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'default_channel_id', // channel id
              'default_channel_name', // channel name
              importance: Importance.max,
              priority: Priority.high,
              playSound: true,
              color: Color(0xffFF4081),
              icon: 'mipmap/notification_icon',
              largeIcon:
                  DrawableResourceAndroidBitmap('mipmap/notification_icon'),
              sound: RawResourceAndroidNotificationSound('notification'),
            ),
          ),
          payload: message.data['id'],
        );
      }
    });

    //android app is in background
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) {
      print(
          'onBackgroundMessage: ${message.notification?.title}/${message.notification?.body}/${message.notification?.titleLocKey}');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'default_channel_id', // channel id
              'default_channel_name', // channel name
              importance: Importance.max,
              priority: Priority.high,
              playSound: true,
              icon: 'mipmap/notification_icon',
              // largeIcon: ,
              color: Color(0xffFF4081),
              sound: RawResourceAndroidNotificationSound('notification'),
            ),
          ),
          payload: message.data['id'],
        );
      }
      throw Error();
    });

    //when a user presses a notification message
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
          try {
        // String? payload = message.data['id'];
        // if (payload != null && payload.isNotEmpty) {
        //   navigatorKey.currentState?.push(MaterialPageRoute(
        //     builder: (context) => HomeScreen(),
        //   ));
        // }
      } catch (e) {
        return;
      }
    });

    //handle notification message if the app was terminated and now opened
    // FirebaseMessaging.instance
    //     .getInitialMessage()
    //     .then((RemoteMessage? message) {
    //   if (message != null) {
    //     try {
    //       String? payload = message.data['id'];
    //       if (payload != null && payload.isNotEmpty) {
    //         navigatorKey.currentState?.push(MaterialPageRoute(
    //           builder: (context) => HomeScreen(),
    //         ));
    //       }
    //     } catch (e) {
    //       return;
    //     }
    //   }
    // });

    //for apple device
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // static void pushNotification() async {}
}
