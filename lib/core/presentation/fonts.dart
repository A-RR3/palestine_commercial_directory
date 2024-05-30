import 'package:videos_application/core/values/cache_keys.dart';
import 'package:videos_application/shared/network/local/cache_helper.dart';

class Fonts {
  static const manropeBold = 'ManropeBold';
  static const cairoBold = 'CairoBold';
  static const manropeMedium = 'ManropeoMedium';
  static const cairoMedium = 'CairoMedium';
  static const cairoLight = 'CairoLight';
  static const manropeoLight = 'ManropeoLight';

  //Splash Screen Font
  static const lobster = 'LobsterRegular';

  static String lang = CacheHelper.getData(CacheKeys.lang.name) ?? 'en';
  static bool isEnLang = lang == "en";

  static String get medium => isEnLang ? manropeMedium : cairoMedium;

  static String get light => isEnLang ? manropeoLight : cairoLight;

  static String get bold => isEnLang ? manropeBold : cairoBold;
}
