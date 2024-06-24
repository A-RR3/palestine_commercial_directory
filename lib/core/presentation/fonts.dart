import 'package:videos_application/core/values/cache_keys.dart';
import 'package:videos_application/shared/network/local/cache_helper.dart';

class Fonts {
  static const String comicSansBold = 'ComicSansBold';
  static const String tajawwalBold = 'TajawwalBold';
  static const String comicSansNormal = 'ComicSansNormal';
  static const String tajawwalRegular = 'TajawwalRegular';

  //Splash Screen Font
  static const lobster = 'LobsterRegular';

  static String? lang = CacheHelper.getData(CacheKeys.lang.name);
  static bool isEnLang = lang == "en";

  static String get medium => isEnLang ? comicSansNormal : tajawwalRegular;

  static String get bold => isEnLang ? comicSansBold : tajawwalBold;
}
