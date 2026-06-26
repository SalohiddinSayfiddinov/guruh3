import 'package:dio/dio.dart';
import 'package:guruh3/features/users/models/user_model.dart';

class UserRepo {
  final Dio dio = Dio();
  Future<List<User>> getUsers() async {
    try {
      final response = await dio.get(
        'https://68a9cff5b115e67576ec277d.mockapi.io/users',
      );
      if (response.statusCode == 200) {
        final List<User> users = (response.data as List).map((e) {
          return User.fromJson(e);
        }).toList();
        return users;
      }
      throw response.data.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createUser(User user) async {
    try {
      final response = await dio.post(
        'https://68a9cff5b115e67576ec277d.mockapi.io/users',
        data: user.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      }
      throw response.data.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(User user) async {
    try {
      final response = await dio.put(
        'https://68a9cff5b115e67576ec277d.mockapi.io/users/${user.id}',
        data: user.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      }
      throw response.data.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(User user) async {
    try {
      final response = await dio.delete(
        'https://68a9cff5b115e67576ec277d.mockapi.io/users/${user.id}',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      }
      throw response.data.toString();
    } catch (e) {
      rethrow;
    }
  }
}
