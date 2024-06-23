import 'dart:ui';

import '../values/constants.dart';

class LocalizationSettings {
  static String defaultLanguage = enCode;
  static Locale defaultLocale = Locale(defaultLanguage);

  static const localesList = [
    Locale('en'),
    Locale('ar'),
  ];
}
