import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guruh3/features/auth/data/model/user_model.dart';

class AuthDataSource {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(UserModel user) async {
    try {
      await _users.doc(user.id).set(user.toMap());
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }
}
