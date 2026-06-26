import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/features/users/presentation/cubit/user_cubit.dart';
import 'package:guruh3/features/users/presentation/screens/users_screen.dart';
import 'package:guruh3/features/users/repos/user_repo.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: BlocProvider(
          create: (context) => UserCubit(repo: UserRepo()),
          child: UsersScreen(),
        ),
      ),
    );
  }
}
