class LoginState {
  final bool isLoading;
  final String? error;
  final bool? isSuccess;

  LoginState({this.isLoading = false, this.error, this.isSuccess});

  @override
  String toString() {
    return "$isLoading, $error, $isSuccess";
  }
}
