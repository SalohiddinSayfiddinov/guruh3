import 'package:flutter/material.dart';

class GapVertical extends StatelessWidget {
  final double gap;
  const GapVertical(this.gap, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: gap);
  }
}

class GapHorizontal extends StatelessWidget {
  final double gap;
  const GapHorizontal(this.gap, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: gap);
  }
}
