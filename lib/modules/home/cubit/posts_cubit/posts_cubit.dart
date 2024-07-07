
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import 'package:palestine_commercial_directory/core/values/constants.dart';
import 'package:palestine_commercial_directory/models/post_model.dart';
import 'package:palestine_commercial_directory/models/array_post_model.dart';
import 'package:palestine_commercial_directory/modules/home/cubit/posts_cubit/posts_states.dart';
import 'package:palestine_commercial_directory/shared/network/remote/end_points.dart';

import '../../../../shared/network/remote/dio_helper.dart';

class PostsCubit extends Cubit<PostsStates> {
  PostsCubit() : super(PostsInitialState());

  static PostsCubit get(context) => BlocProvider.of(context);

  bool isImageSelected = false;
  bool isVideoSelected = false;
  bool isLiked = false;

  ArrayPostModel? postsArrayModel;
  List<Post> posts = [];
  bool isLastPage = false;
  bool hasMore = true;
  int perPage = 4;
  int pageNmber = 1;

  void fetchIfHasData() async {
    hasMore ? await getPosts() : null;
  }

  Future<void> getPosts() async {
    emit(FetchPostsLoadingState());
    await DioHelper.getData(
      url: EndPointsConstants.posts,
      data: {
        "per_page": perPage,
        "page": pageNmber,
      },
      token: userToken,
    ).then((response) {
      postsArrayModel = ArrayPostModel.fromJson(response?.data);

      posts.addAll(postsArrayModel!.posts!);
      pageNmber++;
      if (postsArrayModel!.pagination!.currentPage ==
          postsArrayModel!.pagination!.lastPage) {
        isLastPage = true;
        hasMore = false;
      }
      emit(FetchPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(FetchPostsErrorState());
    });
  }

  void getUserPosts(int userId) async {
    emit(FetchPostsLoadingState());

    await DioHelper.getData(
      url: '${EndPointsConstants.posts}/user/$userId',
      data: {
        "per_page": perPage,
        "page": pageNmber,
      },
      token: userToken,
    ).then((response) {
      postsArrayModel = ArrayPostModel.fromJson(response?.data);
      posts.addAll(postsArrayModel!.posts!);
      pageNmber++;
      if (postsArrayModel!.pagination!.currentPage ==
          postsArrayModel!.pagination!.lastPage) {
        isLastPage = true;
        hasMore = false;
      }
      emit(FetchPostsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(FetchPostsErrorState());
    });
  }

  void toggleLikePost(Post post) async {
    emit(ToggleLikeLoadingState());
    await DioHelper.postData(
        url: EndPointsConstants.toggleLike,
        token: userToken,
        data: {"u_id": post.user?.uId, "p_id": post.pId}).then((response) {
      post.isLiked = !post.isLiked;
      if (post.isLiked) {
        post.likesCount++;
      } else {
        post.likesCount--;
      }
      emit(ToggleLikeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ToggleLikeErrorState());
    });
  }

  SinglePostModel? createdPostModel;

  void createPost(XFile? imageFile, String? mediaType, MediaInfo? mediaInfo,
      String contentEn) async {
    print('inside post$mediaInfo');
    print(mediaType);
    emit(CreatePostLoadingState());
    FormData? formData;
    if (mediaType == 'image') {
      print('is image');
      formData = FormData.fromMap({
        "p_type": mediaType,
        "p_content": contentEn,
        "p_content_ar": 'الترجمة بالعربي',
        "p_user_id": userId!,
        "p_image": await MultipartFile.fromFile(imageFile!.path,
            filename: imageFile.name,
            contentType: MediaType.parse(
                imageFile.mimeType ?? 'application/octet-stream')),
      });
    } else if (mediaType == 'video') {
      print('is video');
      formData = FormData.fromMap({
        "p_type": mediaType,
        "p_content": contentEn,
        "p_content_ar": 'الترجمة بالعربي',
        "p_user_id": userId!,
        "p_video": await MultipartFile.fromFile(
          mediaInfo!.path!,
        )
      });
    } else {
      formData = FormData.fromMap({
        "p_type": mediaType,
        "p_content": contentEn,
        "p_content_ar": 'الترجمة بالعربي',
        "p_user_id": userId!,
      });
    }
    await DioHelper.postData(
      url: EndPointsConstants.posts,
      data: formData,
      contentType: 'multipart/form-data',
      token: userToken,
    ).then((response) {
      createdPostModel = SinglePostModel.fromJson(response?.data);
      Post? post = createdPostModel?.post;
      posts.insert(0, post!);
      print('------------here');

      emit(CreatePostSuccessState(createdPostModel!.message!));
    }).catchError((error) {
      print(error.toString());
      emit(CreatePostErrorState());
    });
  }
}
