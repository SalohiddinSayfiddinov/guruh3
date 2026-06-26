import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/features/users/models/user_model.dart';
import 'package:guruh3/features/users/presentation/cubit/user_cubit.dart';
import 'package:guruh3/features/users/presentation/cubit/user_state.dart';
import 'package:toastification/toastification.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
        ),
      ),
      floatingActionButton: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state.error != null) {
            toastification.show(
              type: ToastificationType.error,
              autoCloseDuration: Duration(seconds: 2),
              title: Text(state.error!),
            );
          } else if (state.successMessage != null) {
            toastification.show(
              type: ToastificationType.success,
              autoCloseDuration: Duration(seconds: 2),
              title: Text(state.successMessage!),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              context.read<UserCubit>().createUser(
                User(id: '', name: nameController.text),
              );
            },
            child: state.isLoading
                ? CircularProgressIndicator.adaptive()
                : Icon(Icons.add),
          );
        },
      ),
    );
  }
}
