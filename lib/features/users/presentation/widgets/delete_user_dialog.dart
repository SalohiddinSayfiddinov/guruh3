import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/features/users/models/user_model.dart';
import 'package:guruh3/features/users/presentation/cubit/user_cubit.dart';
import 'package:guruh3/features/users/presentation/cubit/user_state.dart';
import 'package:toastification/toastification.dart';

class DeleteUserDialog extends StatelessWidget {
  final User user;
  const DeleteUserDialog({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete User'),
      content: Text(
        'Siz haqiqatdan ham ${user.name} foydalanuvchini o\'chirmoqchimisiz?',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        BlocConsumer<UserCubit, UserState>(
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
            return TextButton(
              onPressed: () {
                context.read<UserCubit>().deleteUser(user);
              },
              child: state.isLoading
                  ? CircularProgressIndicator.adaptive()
                  : Text('Okay'),
            );
          },
        ),
      ],
    );
  }
}
