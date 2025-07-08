import 'package:flutter/material.dart';
import 'package:guruh3/core/constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? padding;
  final bool isPrimary;
  final VoidCallback? onPressed;
  final double height;
  final double radius;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.padding,
    this.isPrimary = true,
    this.height = 56.0,
    this.radius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 24.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              isPrimary ? AppColors.primaryColor : Color(0xFFFAF9FD),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: isPrimary ? Colors.white : AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
