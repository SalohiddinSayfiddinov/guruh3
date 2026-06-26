import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/features/login/presentation/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  Random random = Random();

  Future<void> login() async {
    emit(LoginState(isLoading: true));
    await Future.delayed(Duration(seconds: 1));
    if (random.nextBool()) {
      emit(LoginState(isSuccess: true));
    } else {
      emit(LoginState(error: "Xato"));
    }
  }
}
