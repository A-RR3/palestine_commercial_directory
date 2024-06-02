import 'package:videos_application/core/values/cache_keys.dart';
import 'package:videos_application/shared/network/local/cache_helper.dart';

class Fonts {
  static const String manropeBold = 'ManropeBold';
  static const String cairoBold = 'CairoBold';
  static const String manropeMedium = 'ManropeoMedium';
  static const String cairoMedium = 'CairoMedium';
  static const String cairoLight = 'CairoLight';
  static const String manropeoLight = 'ManropeoLight';

  //Splash Screen Font
  static const lobster = 'LobsterRegular';

  static String lang = CacheHelper.getData(CacheKeys.lang.name);
  static bool isEnLang = lang == "en";

  static String get medium => isEnLang ? manropeMedium : cairoMedium;

  static String get light => isEnLang ? manropeoLight : cairoLight;

  static String get bold => isEnLang ? manropeBold : cairoBold;
}
