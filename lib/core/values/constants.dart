import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:videos_application/shared/network/local/cache_helper.dart';
import '../presentation/Palette.dart';
import 'asset_keys.dart';
import 'cache_keys.dart';
import 'lang_keys.dart';

String? userToken;
int? userId;
int? userRole;
bool? isLogged;
String? userImage;
String? userName;

Locale? appLocale;

const String enCode = 'en';
const String arCode = 'ar';

const String splashScreenHeading = 'Palcom';

const String GOOGLE_MAPS_API_KEY = "AIzaSyAin2LBS0Oxgj1CkIWwVvkuOP4Db0oR0bk";

Widget get myDivider => const Divider(color: Colors.grey, thickness: 2);

Widget vSpace([double height = 20]) => SizedBox(
      height: height,
    );
Widget hSpace([double width = 20]) => SizedBox(
      width: width,
    );

const InputBorder loginInputBorder = UnderlineInputBorder(
    borderSide: BorderSide(width: 1.5, color: Palette.border));

void showToast({required String? meg, required ToastStates toastState}) async {
  await Fluttertoast.showToast(
      msg: meg!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor:
          toastState == ToastStates.error ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

// App Bar Gradient
Widget get appBarGradient => Container(
        decoration: BoxDecoration(
      gradient: appGradient,
    ));

Widget get defaultPersonImage => Container(
    width: 65,
    height: 65,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      boxShadow: boxShadow,
    ),
    child: ClipOval(
      // borderRadius: BorderRadius.circular(40),
      child: SvgPicture.asset(
        AssetsKeys.getIconPath(AssetsKeys.DEFAULT_PERSON),
        fit: BoxFit.cover,
      ),
    ));

//
// Widget get defaultPersonImage => ClipOval(
//       child: SvgPicture.asset(
//         AssetsKeys.getIconPath(AssetsKeys.DEFAULT_PERSON),
//         fit: BoxFit.cover,
//       ),
//     );

//Home Page Constants

List<BoxShadow> boxShadow = [
  BoxShadow(
      offset: const Offset(0, 2),
      blurRadius: 5,
      spreadRadius: -4,
      color: Color(0xff000000))
];

List<BoxShadow> textShadow = [
  BoxShadow(
      offset: const Offset(0, 0),
      blurRadius: 20,
      spreadRadius: -10,
      color: Colors.black)
];

Gradient appGradient = LinearGradient(
  tileMode: TileMode.decal,
  colors: [
    // Color(0xffD35E99),
    // Color(0xFFF8BBD0)
    Color(0xffFCA943),
    Color(0xffE41F6E),
  ],
  begin: Alignment.centerRight,
  end: Alignment.centerLeft,
);

class DrawerConstants {
  static const Color drawerItemColorIcon = Colors.blueGrey;
  static const Color drawerItemColorText = Colors.black;
  static final Color? drawerItemSelectedColor = Colors.blue[700];
  static final Color? drawerSelectedTileColor = Colors.blue[100];

  static final drawerItemText = [
    LangKeys.DRAWER_VIDEOS, //0
    LangKeys.CHANGE_LANG, //1
    LangKeys.LOGOUT, //2
  ];

  static final drawerItemIcon = [
    Icons.video_call,
    Icons.language,
    Icons.logout_outlined,
    Icons.delete,
    Icons.saved_search_sharp,
  ];
}
