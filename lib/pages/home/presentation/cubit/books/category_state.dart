import 'package:guruh3/pages/home/data/models/category_model.dart';

abstract class CategoryState {
  const CategoryState();
}

class CategoryInit extends CategoryState {
  const CategoryInit();
}

class CategoryLoading extends CategoryState {
  const CategoryLoading();
}

class CategoryError extends CategoryState {
  final String message;
  const CategoryError({required this.message});
}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;
  const CategoryLoaded({required this.categories});
}
