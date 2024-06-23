class AssetsKeys {
  static String getImagePath(String name, {String extension = 'png'}) =>
      'assets/$IMAGES/$name.$extension';

  static String getIconPath(String name, {String extension = 'svg'}) =>
      'assets/$ICONS/$name.$extension';

  //SUB PATH KEYS
  static const String IMAGES = 'images';
  static const String ICONS = 'icons';
  static const String FILES = 'files';

  //IMAGES KEYS
  static const String SPLASH_SCREEN_IMG = 'palcom_pink';
  static const String LOGIN_SCREEN_IMG = 'login_background';
  static const String DRAWER_IMG = 'drawer_bg';
  static const String PINK_PILLOW = 'undraw_pilates';

  //ICON KEYS
  static const String DEFAULT_PERSON = 'default_profile';
  static const String EDIT_ICON = 'edit_icon';
  static const String Menu_ICON = 'orange_menu_icon';
}
