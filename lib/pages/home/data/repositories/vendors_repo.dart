import 'dart:convert';

import 'package:guruh3/core/constants/api.dart';
import 'package:guruh3/pages/home/data/models/category_model.dart';
import 'package:guruh3/pages/home/data/models/vendor_model.dart';
import 'package:http/http.dart' as http;

class VendorsRepo {
  Future<List<CategoryModel>> fetchVendorCategories() async {
    try {
      final response = await http.get(Uri.parse(Api.vendorCategories));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final List<CategoryModel> categories =
            (data as List).map((e) => CategoryModel.fromJson(e)).toList();
        return categories;
      }
      throw Exception(data['detail'] ?? 'Failed to fetch vendor categories');
    } catch (e) {
      rethrow;
    }
  }

  Future<List<VendorModel>> getVendors({String category = ''}) async {
    final Map<String, dynamic> queryParams = {'category': category};
    try {
      final response = await http.get(Uri.parse(Api.vendors).replace(
        queryParameters: queryParams,
      ));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final List<VendorModel> vendors =
            (data as List).map((e) => VendorModel.fromJson(e)).toList();
        return vendors;
      }
      throw Exception(data['detail'] ?? 'Failed to fetch vendors');
    } catch (e) {
      rethrow;
    }
  }
}
