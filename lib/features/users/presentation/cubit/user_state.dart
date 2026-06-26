import 'package:guruh3/features/users/models/user_model.dart';

class UserState {
  final bool isLoading;
  final String? error;
  final List<User> users;
  final String? successMessage;

  UserState({
    this.isLoading = false,
    this.error,
    this.users = const [],
    this.successMessage,
  });

  UserState copyWith({
    bool? isLoading,
    String? error,
    List<User>? users,
    String? successMessage,
  }) {
    return UserState(
      isLoading: isLoading ?? false,
      error: error,
      users: users ?? this.users,
      successMessage: successMessage,
    );
  }
}
