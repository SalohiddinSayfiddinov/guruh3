import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guruh3/core/constants/app_colors.dart';
import 'package:guruh3/core/widgets/app_buttons.dart';
import 'package:guruh3/core/widgets/app_text_field.dart';
import 'package:guruh3/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:guruh3/pages/auth/presentation/cubit/auth_state.dart';
import 'package:guruh3/pages/auth/presentation/view/code_verification_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  bool hasMinLength(String password) => password.length >= 8;
  bool hasNumber(String password) => RegExp(r'\d').hasMatch(password);
  bool hasLetter(String password) => RegExp(r'[A-Za-z]').hasMatch(password);
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign Up',
                style: GoogleFonts.openSans(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey900,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Create account and choose favorite menu',
                style: GoogleFonts.roboto(
                  fontSize: 16.0,
                  color: AppColors.grey500,
                ),
              ),
              SizedBox(height: 24.0),
              AppTextFieldWithTitle(
                title: 'Name',
                hintText: 'Your name',
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              AppTextFieldWithTitle(
                title: 'Email',
                hintText: 'Your email',
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              AppTextFieldWithTitle(
                title: 'Password',
                hintText: 'Your password',
                isPassword: true,
                controller: _passwordController,
              ),
              SizedBox(height: 16.0),
              _PasswordChecker(
                isPressed: isPressed,
                isCorrect: hasMinLength(_passwordController.text),
                title: 'Minimum 8 characters',
              ),
              SizedBox(height: 8.0),
              _PasswordChecker(
                isPressed: isPressed,
                isCorrect: hasNumber(_passwordController.text),
                title: 'Atleast 1 number (1-9)',
              ),
              SizedBox(height: 8.0),
              _PasswordChecker(
                isPressed: isPressed,
                isCorrect: hasLetter(_passwordController.text),
                title: 'Atleast lowercase or uppercase letters',
              ),
              SizedBox(height: 24.0),
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
                        builder: (context) => BlocProvider(
                          create: (context) => AuthCubit(),
                          child: CodeVerificationPage(
                            email: _emailController.text.trim(),
                          ),
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return PrimaryButton(
                    onPressed: () async {
                      setState(() {
                        isPressed = true;
                      });
                      if (_formKey.currentState!.validate() &&
                          hasMinLength(_passwordController.text) &&
                          hasNumber(_passwordController.text) &&
                          hasLetter(_passwordController.text)) {
                        context.read<AuthCubit>().signUp(
                              _nameController.text.trim(),
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            );
                      }
                    },
                    text: state is AuthLoading ? 'Loading...' : 'Register',
                    padding: EdgeInsets.zero,
                    radius: 48.0,
                    height: 48.0,
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

class _PasswordChecker extends StatelessWidget {
  final bool isPressed;
  final bool isCorrect;
  final String title;
  const _PasswordChecker(
      {required this.isPressed, required this.isCorrect, required this.title});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isPressed,
      child: Row(
        spacing: 12.0,
        children: [
          isCorrect
              ? Icon(Icons.check, color: AppColors.primaryColor)
              : Icon(Icons.remove, color: Colors.red),
          Text(
            title,
            style: GoogleFonts.openSans(color: AppColors.grey500),
          ),
        ],
      ),
    );
  }
}
