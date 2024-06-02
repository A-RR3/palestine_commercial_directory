import 'package:flutter/material.dart';

class Palette {
  static const Color scaffoldBackground = Color(0xffEDF8F9);
  static const Color darkPrimaryColor = Color(0xff333739);
  static const Color primaryColor = Color(0xffA18089);
  static const Color textFieldBackground = Color(0xffF4F4F6);
  static const Color darkThemeText = Colors.white;
  static const Color border = Colors.grey;
  static const Color black = Colors.black;
  static const Gradient gradientColor = LinearGradient(
    colors: [
      Colors.yellowAccent,
      Colors.pinkAccent,
      Color(0xffD35E99),
      Color(0xff623663),
    ],
    stops: [
      0.0,
      0.4,
      0.8,
      1.0,
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
}
