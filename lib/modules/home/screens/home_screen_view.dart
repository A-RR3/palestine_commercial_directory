import 'package:flutter/cupertino.dart';

import '../../../models/post_model.dart';
import '../widgets/post_widget.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final List<Post> posts = [
    Post(
      userName: 'John Doe',
      userImage: 'https://via.placeholder.com/150',
      postContent: 'This is a post content example.',
      postImage: 'https://via.placeholder.com/400',
      likes: 30,
      comments: 10,
    ),
    Post(
      userName: 'Jane Smith',
      userImage: 'https://via.placeholder.com/150',
      postContent: 'Another post content example.',
      postImage: 'https://via.placeholder.com/400',
      likes: 50,
      comments: 20,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostWidget(post: posts[index]);
      },
    );
  }
}
