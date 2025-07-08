import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh3/core/constants/app_colors.dart';
import 'package:guruh3/core/widgets/app_buttons.dart';
import 'package:guruh3/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:guruh3/pages/auth/presentation/cubit/auth_state.dart';
import 'package:guruh3/pages/auth/presentation/view/sign_up_page.dart';
import 'package:guruh3/pages/home/presentation/view/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (state is AuthSuccess) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return PrimaryButton(
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              context.read<AuthCubit>().login(
                                    'user@example.com',
                                    'string',
                                  );
                            },
                      text: state is AuthLoading ? 'Loading...' : 'Login',
                      padding: EdgeInsets.zero,
                      radius: 48.0,
                      height: 48.0,
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => AuthCubit(),
                          child: SignUpPage(),
                        ),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                  ),
                  child: Text('Sign up'),
                ),
              ],
            )),
      ),
    );
  }
}
