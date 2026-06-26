import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/features/users/models/user_model.dart';
import 'package:guruh3/features/users/presentation/cubit/user_state.dart';
import 'package:guruh3/features/users/repos/user_repo.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo repo;
  UserCubit({required this.repo}) : super(UserState());

  Future<void> getUsers() async {
    try {
      emit(state.copyWith(isLoading: true));
      final users = await repo.getUsers();
      emit(state.copyWith(users: users));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> createUser(User user) async {
    try {
      emit(state.copyWith(isLoading: true));
      await repo.createUser(user);
      emit(state.copyWith(successMessage: 'Yaratildi'));
      getUsers();
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> updateUser(User user) async {
    try {
      emit(UserState(isLoading: true));
      await repo.updateUser(user);
      emit(UserState(successMessage: 'Yangilandi'));
    } catch (e) {
      emit(UserState(error: e.toString()));
    }
  }

  Future<void> deleteUser(User user) async {
    try {
      emit(state.copyWith(isLoading: true));
      await repo.deleteUser(user);
      emit(state.copyWith(successMessage: "O'chirildi"));
      getUsers();
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
