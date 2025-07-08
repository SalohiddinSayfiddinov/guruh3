abstract class AuthState {
  const AuthState();
}

class AuthInit extends AuthState {
  const AuthInit();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});
}

class AuthSuccess extends AuthState {
  final String data;
  const AuthSuccess({required this.data});
}
