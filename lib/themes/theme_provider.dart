import 'package:flutter/material.dart';
import 'theme.dart';

class ThemeProvider with ChangeNotifier {
  //initialize
  ThemeData _themeData = lightMode;

  //getter method for access theme
  ThemeData get themeData => _themeData;

  bool get isDarkMode => themeData == darkMode;
  //set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  //toggle theme
  void toggleTheme() {
    if (themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
