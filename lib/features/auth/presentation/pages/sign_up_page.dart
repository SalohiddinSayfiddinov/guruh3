import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:guruh3/features/auth/presentation/cubit/auth_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Center(
          child: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.email),
                  backgroundColor: Colors.green,
                ),
              );
            }
          }, builder: (context, state) {
            return SizedBox(
              height: 50.0,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<AuthCubit>().signUp(
                        'test@gmail.com',
                        'test1234',
                      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: state is AuthLoading
                    ? CircularProgressIndicator.adaptive()
                    : Text('Sign Up'),
              ),
            );
          }),
        ),
      ),
    );
  }
}
