import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/core/values/constants.dart';
import 'package:videos_application/models/post_model.dart';
import 'package:videos_application/models/array_post_model.dart';
import 'package:videos_application/modules/home/cubit/posts_cubit/posts_states.dart';
import 'package:videos_application/shared/network/remote/end_points.dart';

import '../../../../shared/network/remote/dio_helper.dart';

class PostsCubit extends Cubit<PostsStates> {
  PostsCubit() : super(PostsInitialState());

  static PostsCubit get(context) => BlocProvider.of(context);

  bool isImageSelected = false;
  bool isVideoSelected = false;
  int perPage = 18;

  ArrayPostModel? postsArrayModel;
  List<Post> posts = [];

  void getPosts() async {
    emit(FetchPostsLoadingState());

    await DioHelper.getData(
      url: '${EndPointsConstants.posts}?per_page=$perPage',
      token: userToken,
    ).then((response) {
      postsArrayModel = ArrayPostModel.fromJson(response?.data);
      posts.addAll(postsArrayModel!.posts!);
      print('print map result posts: \n');
      posts.map((post) => print(post.toJson()));
      emit(FetchPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(FetchPostsErrorState());
    });
  }
}
