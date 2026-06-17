import 'dart:convert';

import 'package:guruh3/features/post/model/post_model.dart';
import 'package:http/http.dart' as http;

class PostRepo {
  Future<List<Post>> getPosts() async {
    await Future.delayed(Duration(seconds: 1));
    try {
      final response = await http.get(
        Uri.parse('http://jsonplaceholder.typicode.com/posts'),
        headers: {'Accept': 'application/json'},
      );
      final List data = jsonDecode(response.body);
      return data.map((e) => Post.fromJson(e)).toList();
    } catch (e) {
      throw "ERROR: $e";
    }
  }

  Future<void> createPost(Post post) async {
    try {
      final response = await http.post(
        Uri.parse('http://jsonplaceholder.typicode.com/posts'),
        headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json',
        },
        body: jsonEncode(post.toJson()),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw data.toString();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePost(Post post) async {
    try {
      final response = await http.put(
        Uri.parse('http://jsonplaceholder.typicode.com/posts/${post.id}'),
        headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json',
        },
        body: jsonEncode(post.toJson()),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw data.toString();
      }
      print(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      final response = await http.delete(
        Uri.parse('http://jsonplaceholder.typicode.com/posts/$postId'),
        headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json',
        },
      );
      final data = jsonDecode(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw data.toString();
      }
      print(data);
    } catch (e) {
      rethrow;
    }
  }
}
