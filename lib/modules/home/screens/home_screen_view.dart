import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videos_application/modules/home/cubit/posts_cubit/posts_cubit.dart';
import 'package:videos_application/modules/home/cubit/posts_cubit/posts_states.dart';

import '../../../models/post_model.dart';
import '../widgets/post_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => PostsCubit()..getPosts(),
        child: BlocConsumer<PostsCubit, PostsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            PostsCubit postsCubit = PostsCubit.get(context);
            List<Post> posts = postsCubit.posts;

            if (state is FetchPostsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostWidget(post: posts[index]);
              },
            );
          },
        ));
  }
}
