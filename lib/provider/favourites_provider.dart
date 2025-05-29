import 'package:flutter/material.dart';
import 'package:guruh3/models/post.dart';
import 'package:guruh3/repositories/post_repo.dart';

class FavouritesProvider extends ChangeNotifier {
  bool isLoading = false; 
  bool isGetting = false;  
  List<Post> posts = [];
  String? error;

  Future<void> createPost() async {
    isLoading = true;
    notifyListeners();
    final post = await PostRepo().createPost();
    print(post.id);
    isLoading = false;
    notifyListeners();
  }

  Future<void> getPosts() async {
    isGetting = true;
    notifyListeners();
    try {
      final data = await PostRepo().getPosts();
      posts.addAll(data);
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
    isGetting = false;
    notifyListeners();
  }

  final List<Map<String, String>> products = [
    {'name': 'Apple'},
    {'name': 'Banana'},
    {'name': 'Peach'},
    {'name': 'Pineapple'},
  ];
  final List<Map<String, String>> favourites = [];
  void addToFavs(Map<String, String> product) {
    if (favourites.contains(product)) {
      favourites.remove(product);
    } else {
      favourites.add(product);
    }
  }
}
