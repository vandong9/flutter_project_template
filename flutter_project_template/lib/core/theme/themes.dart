import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/diagnostics.dart';

enum ThemeType {
  light,
  dark,
}

final ThemeData _lightTheme = ThemeData(
  fontFamily: 'Gilroy',
  backgroundColor: Colors.white,

  // TextStyle
  textTheme: TextTheme(
    headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    title: TextStyle(
        fontSize: 20.0, fontStyle: FontStyle.italic, color: Colors.blue),
    body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
);

final ThemeData _darkTheme = ThemeData(
  fontFamily: 'Gilroy',
  backgroundColor: Colors.black,
  textTheme: TextTheme(
    headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    title: TextStyle(
        fontSize: 36.0, fontStyle: FontStyle.normal, color: Colors.red),
    body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
);

BaseTheme themeByType(ThemeType type) {
  switch (type) {
    case ThemeType.light:
      return LightTheme();
    case ThemeType.dark:
      return DarkTheme();
  }
}

// if use ThemeData, can not add new theme property by extend class, must use Mixin
// use ThemeData only can custom exist theme properties

// Full Custom theme
const String DefaultFontFamily = "Gilroy";

abstract class BaseTheme {
  Color get colorWhite => Colors.white;
  Color get colorRed => Colors.red;
  Color get colorGreen => Colors.green;
  Color get colorBlue => Colors.blue;
  Color get colorYellow => Colors.yellow;
  Color get colorOrange => Colors.orange;
  Color get colorPink => Colors.pink;

  TextStyle get smallTextStyle => TextStyle();
}

@immutable
class LightTheme extends BaseTheme {
  TextStyle get smallTextStyle => TextStyle(
      fontFamily: DefaultFontFamily,
      fontSize: 10,
      fontWeight: FontWeight.normal);
}

@immutable
class DarkTheme extends BaseTheme {
  TextStyle get smallTextStyle => TextStyle(
      fontFamily: DefaultFontFamily,
      fontSize: 10,
      fontWeight: FontWeight.normal);
}
