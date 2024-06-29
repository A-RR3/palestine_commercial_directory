abstract class PostsStates {}

class PostsInitialState extends PostsStates {}

class FetchPostsLoadingState extends PostsStates {}

class FetchPostsSuccessState extends PostsStates {}

class FetchPostsErrorState extends PostsStates {}

class ShowPostVideoSuccessState extends PostsStates {}

class ShowPostVideoInitialState extends PostsStates {}

class ToggleLikeLoadingState extends PostsStates {}

class ToggleLikeSuccessState extends PostsStates {}

class ToggleLikeErrorState extends PostsStates {}

class CreatePostLoadingState extends PostsStates {}

class CreatePostSuccessState extends PostsStates {
  final String message;
  CreatePostSuccessState(this.message);
}

class CreatePostErrorState extends PostsStates {}
