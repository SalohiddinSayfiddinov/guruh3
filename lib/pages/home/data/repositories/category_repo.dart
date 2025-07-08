import 'dart:convert';

import 'package:guruh3/core/constants/api.dart';
import 'package:guruh3/pages/home/data/models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryRepo {
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse('${Api.baseUrl}${Api.categories}'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final List<CategoryModel> categories =
            (data as List).map((e) => CategoryModel.fromJson(e)).toList();
        return categories;
      }
      throw Exception(data['detail']);
    } catch (e) {
      rethrow;
    }
  }
}
