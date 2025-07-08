import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/pages/auth/presentation/cubit/auth_state.dart';
import 'package:guruh3/pages/auth/repository/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInit());

  Future<void> signUp(String name, String email, String password) async {
    emit(const AuthLoading());
    try {
      final response = await AuthRepo().signUp(name, email, password);
      emit(AuthSuccess(data: response));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> verify(String email, String otp) async {
    emit(const AuthLoading());
    try {
      final response = await AuthRepo().verify(email, otp);
      emit(AuthSuccess(data: response));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(const AuthLoading());
    try {
      final response = await AuthRepo().login(email, password);
      emit(AuthSuccess(data: response));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
