import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/features/auth/data/repo/auth_repo.dart';
import 'package:guruh3/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial());

  Future<void> signUp(String email, String password) async {
    emit(const AuthLoading());
    try {
      final user = await AuthRepo().signUp(email: email, password: password);
      if (user != null) {
        emit(AuthSuccess(user.email ?? ''));
      } else {
        emit(const AuthError('Sign up failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
