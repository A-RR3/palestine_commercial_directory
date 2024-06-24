import 'dart:convert';
import 'pagination_model.dart';
import 'post_model.dart';

ArrayPostModel arrayPostModelFromJson(String str) =>
    ArrayPostModel.fromJson(json.decode(str));

class ArrayPostModel {
  final bool? status;
  final List<Post>? posts;
  final Pagination? pagination;
  final int? postsCount;

  ArrayPostModel({
    this.status,
    this.posts,
    this.pagination,
    this.postsCount,
  });

  factory ArrayPostModel.fromJson(Map<String, dynamic> json) => ArrayPostModel(
        status: json["status"],
        posts: json["posts"] == null
            ? []
            : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
        postsCount: json["posts_count"] ?? 0,
      );
}
