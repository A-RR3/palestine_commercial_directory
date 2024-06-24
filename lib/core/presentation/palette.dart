import 'package:flutter/material.dart';

class Palette {
  static const Color scaffoldBackground = Color(0xFFFAFAFA);
  static const Color scaffoldAppBarColor = Color(0xFFEDEDED);

  static const Color adminPageIconsColor = Color(0xff2589C7);
  static const Color darkPrimaryColor = Color(0xff333739);
  static const Color darkScaffold = Color(0xff333333);
  static const Color primaryColor = Color(0xffA18089);
  static const Color textFieldBackground = Color(0xffF4F4F6);
  static const Color darkThemeText = Colors.white;
  static const Color border = Color(0xff483D41);
  static const Color black = Colors.black;
  static const Gradient gradientColorButton = LinearGradient(
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
  static const Gradient gradientColor = LinearGradient(
    colors: [
      Color(0xff2589C7),
      Color(0xff76C7FC),
      Color(0xffFCA943),
      Color(0xffE41F6E),
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
}
