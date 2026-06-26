import 'package:guruh3/features/post/model/post_model.dart';

class PostState {
  final bool isLoading;
  final String? error;
  final List<Post> posts;

  const PostState({this.isLoading = false, this.error, this.posts = const []});
}
