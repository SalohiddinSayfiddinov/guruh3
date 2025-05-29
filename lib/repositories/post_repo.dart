import 'dart:convert';

import 'package:guruh3/models/post.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class PostRepo {
  final String url = 'http://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> getPosts() async {
    final postBox = Hive.box('postBox');
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        final List<Post> posts = data.map((e) => Post.fromJson(e)).toList();
        await postBox.put('posts', posts);
        return posts;
      } else if (response.statusCode == 400) {
        throw Exception('400');
      }
      throw Exception('else');
    } catch (e) {
      if (postBox.containsKey('posts')) {
        return postBox.get('posts').cast<Post>();
      }
      throw 'Internetingiz o\'chiq';
    }
  }

  Future<Post> createPost() async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            "userId": 1,
            "id": 1,
            "title": 'title',
            "body": 'body',
          },
        ),
      );
      return Post.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw 'Error';
    }
  }
}
