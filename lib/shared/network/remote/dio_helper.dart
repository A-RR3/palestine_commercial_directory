import 'package:dio/dio.dart';
import 'end_points.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response?> getData({
    required String url,
    Map<String, dynamic>? query,
    CancelToken? cancelToken,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await dio.get(
        url,
        queryParameters: query,
        options: Options(
          headers: {
            // 'Authorization': 'Bearer $token',
            // 'x-localization': userLocale == Locale('ar', '') ? 'ar' : 'en',
          },
        ),
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('response is not null');
        print(e.response?.data);
        print(e.response?.statusCode);
        print(e.response?.statusMessage);
        return e.response;
      } else {
        print('response is null');
        print(e.requestOptions);
        print(e.message);
        print(e.error);
      }
    }
    return null;
  }

  static Future<Response?> postData({
    required String url,
    Object? data, //Map<String, dynamic>
    Map<String, dynamic>? query,
    CancelToken? cancelToken,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      // 'x-localization': userLocale == Locale('ar', '') ? 'ar' : 'en',
    };
    try {
      final response = await dio.post(url,
          data: data,
          queryParameters: query,
          // options: Options(headers: {'Authorization': 'Bearer $token'}),
          cancelToken: cancelToken);
      print('response is good');
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print('response is not null');
        print(e.response?.data);
        print(e.response?.statusCode);
        print(e.response?.statusMessage);
        return e.response;
      } else {
        print('response is null');
        print(e.requestOptions);
        print(e.message);
        print(e.error);
      }
    }
    return null;
    // add throw
  }

  static Future<Response?> putData({
    required String url,
    Object? data,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      // 'x-localization': userLocale == Locale('ar', '') ? 'ar' : 'en',
    };
    try {
      final response = await dio.put(
        url,
        data: data,
        queryParameters: query,
        // options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.statusCode);
        print(e.response?.statusMessage);
        return e.response;
      } else {
        print(e.requestOptions);
        print(e.message);
        print(e.error);
      }
    }
    return null;
  }
}