import 'package:videos_application/core/values/local_storage_keys.dart';
import 'package:videos_application/shared/network/local/cache_helper.dart';

class Fonts {
  static const manropeBold = 'ManropeBold';
  static const cairoBold = 'CairoBold';
  static const manropeMedium = 'ManropeoMedium';
  static const cairoMedium = 'CairoMedium';
  static const cairoLight = 'CairoLight';
  static const manropeoLight = 'ManropeoLight';

  static String lang = CacheHelper.getData(LocalStorageKeys.APP_LANG_KEY);
  static bool isEnLang = lang == "en";

  static String get medium => isEnLang ? manropeMedium : cairoMedium;

  static String get light => isEnLang ? manropeoLight : cairoLight;

  static String get bold => isEnLang ? manropeBold : cairoBold;
}
