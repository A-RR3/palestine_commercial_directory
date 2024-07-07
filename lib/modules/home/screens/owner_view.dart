import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palestine_commercial_directory/core/values/cache_keys.dart';
import 'package:palestine_commercial_directory/permission_cubit/permission_cubit.dart';

import '../../../core/values/constants.dart';
import '../../../models/post_model.dart';
import '../../admin/screens/users/cubit/scroll_cubit.dart';
import '../cubit/posts_cubit/posts_cubit.dart';
import '../cubit/posts_cubit/posts_states.dart';
import '../widgets/post_widget.dart';
import 'create_post_widget.dart';

class CompanyOwnerView extends StatelessWidget {
  const CompanyOwnerView({super.key, this.userId});
  final int? userId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PermissionsCubit(),
          ),
          BlocProvider(
            create: (context) => PostsCubit()..getUserPosts(userId!),
          ),
          BlocProvider(
            create: (context) => ScrollCubit(),
          )
        ],
        child: BlocConsumer<PostsCubit, PostsStates>(
          listener: (context, state) {
            if (state is CreatePostSuccessState) {
              showToast(meg: state.message, toastState: ToastStates.success);
            }
          },
          builder: (context, state) {
            PostsCubit postsCubit = PostsCubit.get(context);
            List<Post> posts = postsCubit.posts;
            FocusScopeNode focusScopNode = FocusScopeNode();

            if (state is FetchPostsLoadingState && posts.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return BlocConsumer<ScrollCubit, bool>(
              listener: (scrollContext, scrollState) {
                print(scrollState);
                if (scrollState) {
                  postsCubit.fetchIfHasData();
                }
              },
              builder: (scrollContext, scrollState) {
                // ScrollCubit scrollCubit =
                //     ScrollCubit(MediaQuery.of(context).size.height);
                ScrollCubit scrollCubit = ScrollCubit.get(scrollContext);

                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    // Unfocus the text field when tapping outside
                    focusScopNode.unfocus();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SingleChildScrollView(
                      controller: scrollCubit.scrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          PostScreen(postsCubit, focusScopNode),
                          vSpace(20),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            // controller: scrollCubit.scrollController,
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
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
