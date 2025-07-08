import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guruh3/core/constants/app_colors.dart';
import 'package:guruh3/core/widgets/app_buttons.dart';
import 'package:guruh3/core/widgets/gaps.dart';
import 'package:guruh3/pages/auth/presentation/cubit/auth_cubit.dart';
import 'package:guruh3/pages/auth/presentation/cubit/auth_state.dart';
import 'package:guruh3/pages/auth/presentation/view/login_page.dart';
import 'package:pinput/pinput.dart';

class CodeVerificationPage extends StatefulWidget {
  final String email;
  const CodeVerificationPage({super.key, required this.email});

  @override
  State<CodeVerificationPage> createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Column(children: [
              Text(
                'Verification Email',
                style: GoogleFonts.openSans(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey900,
                ),
              ),
              GapVertical(8.0),
              Text(
                'Please enter the code we just sent to email',
                style: GoogleFonts.roboto(
                  fontSize: 16.0,
                  color: AppColors.grey500,
                ),
              ),
              Text(
                widget.email,
                style: GoogleFonts.roboto(
                  fontSize: 16.0,
                  color: AppColors.grey900,
                ),
              ),
              GapVertical(40.0),
              Pinput(
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                controller: _controller,
                enabled: false,
                length: 4,
                defaultPinTheme: PinTheme(
                  margin: EdgeInsets.only(right: 16.0),
                  textStyle: GoogleFonts.openSans(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey900,
                  ),
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Color(0xFFFAFAFA),
                  ),
                ),
              ),
              GapVertical(43.0),
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
                          child: LoginPage(),
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return PrimaryButton(
                    onPressed: state is AuthLoading
                        ? null
                        : () {
                            if (_controller.text.length == 4) {
                              context.read<AuthCubit>().verify(
                                    widget.email,
                                    _controller.text.trim(),
                                  );
                            }
                          },
                    text: state is AuthLoading ? 'Loading' : 'Continue',
                    padding: EdgeInsets.zero,
                    radius: 48.0,
                    height: 48.0,
                  );
                },
              )
            ]),
          ),
          Spacer(),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: GridView.builder(
              itemCount: 12,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 80.0,
              ),
              itemBuilder: (context, index) {
                return Material(
                  color: AppColors.primaryColor,
                  child: InkWell(
                    onTap: () {
                      if (index == 11) {
                        if (_controller.text.isNotEmpty) {
                          _controller.text = _controller.text.substring(
                            0,
                            _controller.text.length - 1,
                          );
                        }
                      } else {
                        if (_controller.length < 4) {
                          _controller.text += _showText(index);
                        }
                      }
                    },
                    child: Center(
                      child: index == 11
                          ? Icon(
                              Icons.backspace_outlined,
                              color: Colors.white,
                            )
                          : Text(
                              _showText(index),
                              style: GoogleFonts.openSans(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _showText(int index) {
    if (index == 9) {
      return '.';
    } else if (index == 10) {
      return '0';
    } else {
      return '${index + 1}';
    }
  }
}
