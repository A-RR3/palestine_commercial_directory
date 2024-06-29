import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palestine_commercial_directory/modules/admin/screens/users/cubit/scroll_cubit.dart';
import 'package:palestine_commercial_directory/modules/home/cubit/posts_cubit/posts_cubit.dart';
import 'package:palestine_commercial_directory/modules/home/cubit/posts_cubit/posts_states.dart';

import '../../../core/values/cache_keys.dart';
import '../../../core/values/constants.dart';
import '../../../models/post_model.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../widgets/post_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PostsCubit()..getPosts(),
          ),
          BlocProvider(
            create: (context) => ScrollCubit(),
          )
        ],
        child: BlocConsumer<PostsCubit, PostsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            PostsCubit postsCubit = PostsCubit.get(context);
            List<Post> posts = postsCubit.posts;

            if (state is FetchPostsLoadingState && posts.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return BlocConsumer<ScrollCubit, bool>(
              listener: (context, scrollState) {
                if (scrollState) {
                  postsCubit.fetchIfHasData();
                }
              },
              builder: (context, scrollState) {
                ScrollCubit scrollCubit = ScrollCubit.get(context);

                return ListView.builder(
                  controller: scrollCubit.scrollController,
                  itemCount: posts.length + (postsCubit.isLastPage ? 0 : 1),
                  itemBuilder: (context, index) {
                    if (index < posts.length) {
                      return PostWidget(
                        post: posts[index],
                        postsCubit: postsCubit,
                      );
                    } else {
                      return postsCubit.hasMore
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : vSpace();
                    }
                  },
                );
              },
            );
          },
        ));
  }
}
