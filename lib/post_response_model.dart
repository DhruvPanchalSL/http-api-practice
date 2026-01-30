
import 'package:api_practice/post_model.dart';

class PostResponse {
  final List<Post> posts;
  final int total;
  final int skip;
  final int limit;

  PostResponse({required this.posts,
    required this.total,
    required this.skip,
    required this.limit
  });
  factory PostResponse.fromJson(Map<String,dynamic>json){
    return  PostResponse(
    posts: (json['posts'] as List).map((e)=>Post.fromJson(e)).toList(),
    total: json['total'],
    skip: json['skip'],
    limit: json['limit'],
  );
}
}