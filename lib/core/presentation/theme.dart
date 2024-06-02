import 'package:flutter/material.dart';
import 'package:videos_application/core/presentation/fonts.dart';

import '../presentation/Palette.dart';

ThemeData get lightTheme => ThemeData(
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: false,
    appBarTheme: appBarTheme(),
    bottomNavigationBarTheme: navBarTheme(),
    textTheme: textTheme,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Palette.primaryColor));

ThemeData get darkTheme => ThemeData(
      scaffoldBackgroundColor: Palette.darkPrimaryColor,
      useMaterial3: false,
      appBarTheme: appBarTheme(
        textColor: Colors.white,
        backgroundColor: Palette.darkPrimaryColor,
        iconColor: Colors.white,
      ),
      bottomNavigationBarTheme: navBarTheme(
          backgroundColor: Palette.darkPrimaryColor,
          unselectedItemColor: Colors.grey),
      textTheme: textTheme,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Palette.primaryColor,
      ),
    );

BottomNavigationBarThemeData navBarTheme(
    {Color? unselectedItemColor, Color? backgroundColor}) {
  return BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Palette.primaryColor,
      unselectedItemColor: unselectedItemColor ?? Colors.black,
      backgroundColor: backgroundColor ?? Colors.white);
}

AppBarTheme appBarTheme(
        {Color? textColor, Color? backgroundColor, Color? iconColor}) =>
    AppBarTheme(
      titleSpacing: 20,
      titleTextStyle: TextStyle(
        color: textColor ?? Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: backgroundColor ?? Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: iconColor ?? Colors.black, size: 23),
    );

TextTheme get textTheme => TextTheme(
    bodyLarge: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w500, fontFamily: Fonts.medium),
    bodyMedium: TextStyle(
        fontSize: 17, fontWeight: FontWeight.w500, fontFamily: Fonts.medium),
    bodySmall: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, fontFamily: Fonts.medium),
    labelLarge: TextStyle(
        fontSize: 25, fontWeight: FontWeight.w800, fontFamily: Fonts.bold),
    labelSmall: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w500, fontFamily: Fonts.medium),
    labelMedium: TextStyle(
        fontSize: 23, fontWeight: FontWeight.w500, fontFamily: Fonts.bold));
