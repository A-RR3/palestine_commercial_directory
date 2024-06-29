import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palestine_commercial_directory/core/utils/extensions.dart';
import 'package:palestine_commercial_directory/core/values/constants.dart';
import 'package:palestine_commercial_directory/modules/home/cubit/posts_cubit/posts_cubit.dart';
import 'package:palestine_commercial_directory/modules/home/cubit/posts_cubit/video_cubit.dart';
import 'package:palestine_commercial_directory/shared/network/remote/end_points.dart';
import '../../../core/values/cache_keys.dart';
import '../../../models/post_model.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/widgets/custom_text_widget.dart';
import '../cubit/posts_cubit/posts_states.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final PostsCubit postsCubit;

  PostWidget({
    super.key,
    required this.post,
    required this.postsCubit,
  });

  @override
  Widget build(BuildContext context) {
    bool isEnglish = CacheHelper.getData(CacheKeys.lang.name) == enCode;
    bool isLogged = CacheHelper.getBool(CacheKeys.isLogged.name);
    return Card(
      shadowColor: Colors.grey,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                defaultContainer(
                    height: 50,
                    width: 50,
                    child: post.user?.uImage != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(
                                '${EndPointsConstants.usersStorage}${post.user!.uImage}'))
                        : defaultPersonImage),
                hSpace(),
                DefaultText(
                  text: isEnglish ? post.user!.uName! : post.user!.uNameAr!,
                  color: Colors.black,
                ),
              ],
            ),
            vSpace(),
            DefaultText(
              text: post.pContent != null ? post.pContent! : '',
              style: context.textTheme.bodyMedium,
            ),
            vSpace(),
            post.pImage != null
                ? Image.network(
                    '${EndPointsConstants.imagesStorage}${post.pImage}')
                : post.pVideo != null
                    ? BlocProvider(
                        create: (context) =>
                            VideoCubit()..viewVideo(post.pVideo!),
                        child: BlocConsumer<VideoCubit, PostsStates>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            VideoCubit videoCubit = VideoCubit.get(context);
                            return videoCubit.chewieController != null &&
                                    videoCubit
                                        .chewieController!
                                        .videoPlayerController
                                        .value
                                        .isInitialized
                                ? GestureDetector(
                                    onTap: videoCubit.togglePlayPause,
                                    child: AspectRatio(
                                      aspectRatio: videoCubit
                                          .chewieController!.aspectRatio!,
                                      child: Chewie(
                                          controller:
                                              videoCubit.chewieController!),
                                    ),
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  );
                          },
                        ))
                    : const SizedBox(),
            vSpace(),
            !isLogged ? likeRow : toggleLikeRow
          ],
        ),
      ),
    );
  }

  Widget get likeRow => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.thumb_up),
              const SizedBox(width: 5),
              Text('${post.likesCount} Likes'),
            ],
          ),
          Row(
            children: <Widget>[
              const Icon(Icons.comment),
              const SizedBox(width: 5),
              Text('${post.likesCount} Comments'),
            ],
          ),
        ],
      );
  Widget get toggleLikeRow => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () => postsCubit.toggleLikePost(post),
            child: Row(
              children: <Widget>[
                Text('${post.likesCount}'),
                hSpace(5),
                const Icon(Icons.thumb_up),
                hSpace(5),
                post.isLiked ? Text('DisLike') : Text('Like')
              ],
            ),
          ),
          Row(
            children: <Widget>[
              const Icon(Icons.comment),
              const SizedBox(width: 5),
              Text('Comment'),
            ],
          ),
        ],
      );
}
