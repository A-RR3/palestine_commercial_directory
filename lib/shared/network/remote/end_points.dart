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
  static const String subBaseUrl = 'http://192.168.1.16/laravel_project';

  static const String baseUrl = '$subBaseUrl/public/api/';
  static const String post = 'post';

  static const usersStorage = '$subBaseUrl/storage/app/public/users/images/';

  static const String videos = 'videos';

  static const String videosStorage =
      '$subBaseUrl/public/storage/posts/videos/';
}
