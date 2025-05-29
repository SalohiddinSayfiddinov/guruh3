import 'dart:convert';

import 'package:guruh3/models/user.dart';
import 'package:http/http.dart' as http;

class UserRepo {
  Future<List<User>> getUsers() async {
    try {
      final response = await http.get(
        Uri.parse('https://6817aba126a599ae7c3b1608.mockapi.io/api/v1/users'),
      );

      final List data = jsonDecode(response.body);
      final List<User> users = data.map((e) => User.fromJson(e)).toList();

      return users;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> createUser(User user) async {
    try {
      await http.post(
        Uri.parse('https://6817aba126a599ae7c3b1608.mockapi.io/api/v1/users'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            "name": user.name,
            "avatar": user.avatar,
          },
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> updateUser(User user) async {
    try {
      await http.put(
        Uri.parse(
            'https://6817aba126a599ae7c3b1608.mockapi.io/api/v1/users/${user.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            "id": user.id,
            "name": user.name,
            "avatar": user.avatar,
            "createdAt": user.createdAt
          },
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await http.delete(
        Uri.parse(
            'https://6817aba126a599ae7c3b1608.mockapi.io/api/v1/users/$userId'),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
