import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/features/post/cubit/post_state.dart';
import 'package:guruh3/features/post/repo/post_repo.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostState());

  Future<void> getPosts() async {
    try {
      emit(PostState(isLoading: true));
      final posts = await PostRepo().getPosts();
      emit(PostState(posts: posts));
    } catch (e) {
      emit(PostState(error: e.toString()));
    }
  }
}
