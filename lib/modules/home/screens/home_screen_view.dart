import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palestine_commercial_directory/modules/admin/screens/users/cubit/scroll_cubit.dart';
import 'package:palestine_commercial_directory/modules/home/cubit/posts_cubit/posts_cubit.dart';
import 'package:palestine_commercial_directory/modules/home/cubit/posts_cubit/posts_states.dart';
import 'package:palestine_commercial_directory/shared/widgets/custom_text_widget.dart';

import '../../../core/values/constants.dart';
import '../../../models/post_model.dart';
import '../widgets/carousel_slider_widget.dart';
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

                return Padding(
                    padding: const EdgeInsets.all(1),
                    child: SingleChildScrollView(
                      controller: scrollCubit.scrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CaroaselSlider(),
                          vSpace(20),
                          const DefaultText(text: 'All Posts'),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                posts.length + (postsCubit.isLastPage ? 0 : 1),
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
                          )
                        ],
                      ),
                    ));
              },
            );
          },
        ));
  }
}
