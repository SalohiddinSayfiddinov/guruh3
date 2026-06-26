import 'dart:ui';

class TextChanged {
  final bool loading;
  final Color color;
  final String text;

  TextChanged({required this.text, required this.color, this.loading = false});
}
