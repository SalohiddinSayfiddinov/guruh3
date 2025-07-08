import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guruh3/core/constants/app_colors.dart';

class AppTextFieldWithTitle extends StatelessWidget {
  final String title;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const AppTextFieldWithTitle({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.validator,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6.0,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            color: AppColors.grey900,
          ),
        ),
        AppTextField(
          hintText: hintText,
          isPassword: isPassword,
          controller: controller,
          validator: validator,
        ),
      ],
    );
  }
}

class AppTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const AppTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.validator,
    this.isPassword = false,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(
            color: AppColors.primaryColor,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        fillColor: Color(0xFFFAFAFA),
        filled: true,
        hintText: widget.hintText,
        hintStyle: GoogleFonts.roboto(fontSize: 16.0, color: Color(0xFFB8B8B8)),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                icon: obscure
                    ? SvgPicture.asset('assets/icons/eye.svg')
                    : SvgPicture.asset('assets/icons/eye-slash.svg'),
              )
            : null,
      ),
      style: GoogleFonts.roboto(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: AppColors.primaryColor,
      cursorHeight: 20.0,
      cursorWidth: 2.0,
      obscureText: widget.isPassword && obscure,
      validator: widget.validator,
    );
  }
}
