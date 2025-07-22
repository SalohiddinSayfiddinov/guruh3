import 'package:firebase_auth/firebase_auth.dart';
import 'package:guruh3/features/auth/data/model/user_model.dart';
import 'package:guruh3/features/auth/data/repo/auth_data_source.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthDataSource _authDataSource = AuthDataSource();

  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        UserModel user = UserModel(
          id: result.user!.uid,
          email: result.user!.email!,
          name: 'John',
        );
        await _authDataSource.createUser(user);
      }
      return result.user;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }
}
