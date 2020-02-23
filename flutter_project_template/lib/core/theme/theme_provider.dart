import 'package:flutter/material.dart';

import 'themes.dart';

class ThemeProvider extends ChangeNotifier {
  // Section: Variable and Constant
  ThemeType _curThemeType;
  BaseTheme _themeData;
  BaseTheme get currentTheme => _themeData;

  ThemeProvider(ThemeType curThemeType) {
    _curThemeType = curThemeType;
    _themeData = themeByType(curThemeType);
  }

  // Section: Public
  getTheme() => _themeData;

  setTheme(ThemeType type) {
    _curThemeType = type;
    _themeData = themeByType(_curThemeType);
    notifyListeners();
  }
}
