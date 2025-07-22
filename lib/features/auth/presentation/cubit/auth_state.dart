abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final String email;

  const AuthSuccess(this.email);
}

class AuthError extends AuthState {
  final String error;

  const AuthError(this.error);
}
