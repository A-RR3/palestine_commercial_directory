import 'package:dio/dio.dart';

mixin CancelTokenMixin {
  CancelToken cancelToken = CancelToken();

  void cancelRequestToken() {
    if (!cancelToken.isCancelled) {
      cancelToken.cancel('Cancelled');
    }
    cancelToken = CancelToken();
  }
}
