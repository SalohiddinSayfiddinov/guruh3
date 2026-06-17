import 'package:flutter/material.dart';
import 'package:guruh3/features/post/model/post_model.dart';
import 'package:guruh3/features/post/repo/post_repo.dart';

class PostProvider extends ChangeNotifier {
  bool isLoading = false;
  String? error;
  List<Post>? posts;

  Future<void> getPosts() async {
    try {
      isLoading = true;
      error = null;
      posts = null;
      notifyListeners();
      posts = await PostRepo().getPosts();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //
  bool isCreating = false;
  bool? isCreated;
  String? createError;

  Future<void> createPost(Post post) async {
    try {
      isCreating = true;
      createError = null;
      isCreated = null;
      notifyListeners();
      await PostRepo().createPost(post);
      isCreated = true;
    } catch (e) {
      createError = e.toString();
    } finally {
      isCreating = false;
      notifyListeners();
    }
  }

  int updatingId = -1;
  String? updateError;
  bool? isUpdated;

  Future<void> updatePost(Post post) async {
    try {
      updatingId = post.id;
      updateError = null;
      isUpdated = null;
      notifyListeners();
      await PostRepo().updatePost(post);
      isUpdated = true;
    } catch (e) {
      updateError = e.toString();
    } finally {
      updatingId = -1;
      notifyListeners();
    }
  }

  int deletingId = -1;
  String? deleteError;
  bool? isDeleted;

  Future<void> deletePost(int postId) async {
    try {
      deletingId = postId;
      deleteError = null;
      isDeleted = null;
      notifyListeners();
      await PostRepo().deletePost(postId);
      isDeleted = true;
    } catch (e) {
      deleteError = e.toString();
    } finally {
      deletingId = -1;
      notifyListeners();
    }
  }
}
