import 'dart:convert';

import 'package:guruh3/core/constants/api.dart';
import 'package:guruh3/pages/orders/data/models/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepo {
  Future<String> placeOrder(double lat, double long, String date) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    try {
      final response = await http.post(
        Uri.parse(Api.postOrder),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(
          {"latitude": lat, "longitude": long, "datetime": date},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'Order placed successfully';
      } else {
        throw Exception('Failed to place order');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrderModel>> getOrders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    try {
      final response = await http.get(
        Uri.parse(Api.postOrder),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        final List<OrderModel> orders =
            data.map((e) => OrderModel.fromJson(e)).toList();
        return orders;
      } else {
        throw Exception('Failed to fetch orders');
      }
    } catch (e) {
      rethrow;
    }
  }
}
