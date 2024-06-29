const LOGIN = 'login';

const USERS = 'users';

const COMPANIES = 'companies';

const CATEGORIES = 'categories';

const ARCHIVED_USERS = 'archived';

const HOME = 'home';

const LOGOUT = 'logout';

const USERS_SEARCH = 'users/search';

class EndPointsConstants {
  // static const String subBaseUrl = 'http://192.168.1.10/BFO/palestine_commercial_directory_laravel';
  static const String subBaseUrl = 'http://192.168.1.23/laravel_project';

  static const String baseUrl = '$subBaseUrl/public/api/';
  static const String post = 'post';

  static const usersStorage = '$subBaseUrl/storage/app/public/users/images/';
  static const imagesStorage = '$subBaseUrl/storage/app/public/posts/images/';
  static const String videosStorage =
      '$subBaseUrl/storage/app/public/posts/videos/';
  static const String posts = 'posts';
  static const String update = 'update';
  static const String toggleLike = 'posts/toggleLike';

  static const String videos = 'videos';

  // static const String videosStorage =
  //     '$subBaseUrl/public/storage/posts/videos/';
}
