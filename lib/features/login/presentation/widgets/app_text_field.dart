import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isPassword;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        labelText: widget.hintText,

        suffixIcon: widget.isPassword
            ? Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscure = !_obscure;
                    });
                  },
                  icon: Icon(
                    _obscure ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                    color: Colors.grey.shade600,
                  ),
                ),
              )
            : null,
      ),

      obscureText: widget.isPassword ? _obscure : false,
      validator: (value) {
        if (value!.isEmpty) {
          return "Iltimos to'ldiring";
        }
        return null;
      },
    );
  }
}
