import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/features/login/presentation/cubit/login_cubit.dart';
import 'package:guruh3/features/login/presentation/cubit/login_state.dart';
import 'package:guruh3/features/login/presentation/widgets/app_text_field.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 200),
              AppTextField(controller: emailController, hintText: 'Email'),
              SizedBox(height: 10.0),
              AppTextField(
                controller: passwordController,
                hintText: 'Password',
                isPassword: true,
              ),
              SizedBox(height: 30.0),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state.error != null) {
                    toastification.show(
                      context: context,
                      type: .error,
                      title: Text(state.error.toString()),
                      autoCloseDuration: const Duration(seconds: 2),
                    );
                  } else if (state.isSuccess == true) {
                    toastification.show(
                      context: context,
                      type: .success,
                      title: Text('Success'),
                      autoCloseDuration: const Duration(seconds: 5),
                    );
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    height: 44.0,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<LoginCubit>().login();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      child: state.isLoading
                          ? CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.white,
                            )
                          : Text('Login'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
