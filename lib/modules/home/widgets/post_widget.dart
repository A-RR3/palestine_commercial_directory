import 'package:flutter/material.dart';
import 'package:videos_application/core/utils/extensions.dart';
import 'package:videos_application/core/values/constants.dart';
import '../../../models/post_model.dart';
import '../../../shared/widgets/custom_text_widget.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  PostWidget({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(post.userImage),
                  ),
                ),
                hSpace(),
                DefaultText(
                  text: post.userName,
                  color: Colors.black,
                ),
              ],
            ),
            vSpace(),
            DefaultText(
              text: post.postContent,
              style: context.textTheme.bodyMedium,
            ),
            vSpace(),
            if (post.postImage.isNotEmpty) Image.network(post.postImage),
            vSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.thumb_up),
                    SizedBox(width: 5),
                    Text('${post.likes} Likes'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.comment),
                    SizedBox(width: 5),
                    Text('${post.comments} Comments'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
