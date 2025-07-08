import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/pages/home/data/repositories/category_repo.dart';
import 'package:guruh3/pages/home/presentation/cubit/books/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInit());

  Future<void> getCategories() async {
    emit(CategoryLoading());
    try {
      final categories = await CategoryRepo().getCategories();
      emit(CategoryLoaded(categories: categories));
    } catch (e) {
      emit(CategoryError(message: e.toString()));
    }
  }
}
