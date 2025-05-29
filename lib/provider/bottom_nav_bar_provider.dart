import 'package:flutter/material.dart';

class BottomNavBarProvider extends ChangeNotifier {
  int currentIndex = 0;

  void changePage(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
