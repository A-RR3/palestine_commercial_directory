import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../shared/network/local/cache_helper.dart';
import '../presentation/Palette.dart';
import 'cache_keys.dart';

// String? userToken;
// int? userId;
// int? userRole;
// bool isLogged = false;

String? userToken = CacheHelper.getData(CacheKeys.token.name);
bool isLogged = CacheHelper.getData(CacheKeys.isLogged.name) ?? false;
int? userId = CacheHelper.getData(CacheKeys.userId.name);
int? userRole = CacheHelper.getData(CacheKeys.userRole.name);

Locale userLocale =
    CacheHelper.getData(CacheKeys.lang.name) ?? const Locale(enCode);

const String enCode = 'en';
const String arCode = 'ar';

const String splashScreenHeading = 'Palcom';

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
