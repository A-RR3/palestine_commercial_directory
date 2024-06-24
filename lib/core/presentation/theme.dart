import 'package:flutter/material.dart';
import 'package:videos_application/core/presentation/fonts.dart';
import '../presentation/Palette.dart';

ThemeData get lightTheme => ThemeData(
      scaffoldBackgroundColor: Palette.scaffoldBackground,
      useMaterial3: false,
      appBarTheme: appBarTheme(
          backgroundColor: Palette.scaffoldAppBarColor,
          textColor: Colors.black,
          iconColor: Colors.white),
      bottomNavigationBarTheme: navBarTheme(),
      textTheme: textTheme,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Palette.primaryColor),
      // cardColor: ,
      tabBarTheme: TabBarTheme(
          labelStyle: TextStyle(
              color: Colors.black, fontFamily: Fonts.bold, fontSize: 20)),
      cardTheme: CardTheme(
        shadowColor: Colors.red,
        color: Palette.scaffoldAppBarColor,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      iconTheme: const IconThemeData(color: Palette.adminPageIconsColor),

      listTileTheme: ListTileThemeData(
        minVerticalPadding: 10,
        iconColor: Palette.black,
        titleTextStyle: TextStyle(
          fontFamily: Fonts.medium,
          color: Colors.black,
          fontSize: 22,
        ),
        subtitleTextStyle: const TextStyle(
            fontFamily: Fonts.tajawwalBold,
            color: Palette.adminPageIconsColor,
            fontSize: 18),
        tileColor: Palette.scaffoldAppBarColor,
        contentPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        minLeadingWidth: 40,
      ),
    );

ThemeData get darkTheme => ThemeData(
    scaffoldBackgroundColor: const Color(0xffA18089),
    useMaterial3: false,
    appBarTheme: appBarTheme(
      textColor: const Color(0xFF263238),
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
    cardTheme: CardTheme(
      color: const Color(0xFF37474F),
      elevation: 5.0,
      shadowColor: Colors.deepPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ));

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
          fontSize: 20, fontWeight: FontWeight.w600, fontFamily: Fonts.medium),
      bodyMedium: TextStyle(
          fontSize: 17, fontWeight: FontWeight.w600, fontFamily: Fonts.medium),
      bodySmall: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, fontFamily: Fonts.medium),
      labelLarge: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w600, fontFamily: Fonts.bold),
      labelSmall: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600, fontFamily: Fonts.medium),
      labelMedium: TextStyle(
          fontSize: 22, fontWeight: FontWeight.w500, fontFamily: Fonts.medium),
      headlineSmall: const TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
    );
