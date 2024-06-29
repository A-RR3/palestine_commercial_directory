import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

void showToast(
    {required String? meg,
    required ToastStates toastState,
    Color? color}) async {
  await Fluttertoast.showToast(
      msg: meg!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: toastState == ToastStates.error
          ? Colors.red
          : toastState == ToastStates.success
              ? Colors.green
              : Color(0xffE4CF03),
      textColor: color ?? Colors.white,
      fontSize: 16.0);
}

// App Bar Gradient
Widget get appBarGradient => Container(
        decoration: BoxDecoration(
      gradient: appGradient,
    ));

Widget defaultContainer(
        {required Widget child,
        double height = 65,
        double width = 65,
        double radius = 40,
        bool hasShadow = false}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: hasShadow ? boxShadow : null,
      ),
      child: child,
    );

Widget get defaultPersonImage => ClipOval(
      child: SvgPicture.asset(
        AssetsKeys.getIconPath(AssetsKeys.DEFAULT_PERSON),
        fit: BoxFit.cover,
      ),
    );

//
// Widget get defaultPersonImage => ClipOval(
//       child: SvgPicture.asset(
//         AssetsKeys.getIconPath(AssetsKeys.DEFAULT_PERSON),
//         fit: BoxFit.cover,
//       ),
//     );

//Home Page Constants

List<BoxShadow> boxShadow = [
  const BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 5,
      spreadRadius: -4,
      color: Color(0xff000000))
];

List<BoxShadow> textShadow = [
  const BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 20,
      spreadRadius: -10,
      color: Colors.black)
];

Gradient appGradient = const LinearGradient(
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
