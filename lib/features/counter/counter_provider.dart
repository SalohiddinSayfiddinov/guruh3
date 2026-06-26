import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int count = 0;
  int color = 0;
  void kopaytir() {
    count++;
    notifyListeners();
  }
}
