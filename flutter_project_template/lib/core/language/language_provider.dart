import 'package:flutter/material.dart';
import 'base_language.dart';
import 'languages/english.dart';
import 'languages/vietnamese.dart';

class LanguageProvider extends ChangeNotifier {
  BaseLanguage _currentLanguage;

  LanguageProvider() {
    _currentLanguage = EnglishLanguage();
  }

  BaseLanguage getCurrentLanguage() => _currentLanguage;

  void changeLanguage(BaseLanguage newLangauge) {
    _currentLanguage = newLangauge;
    notifyListeners();
  }

  void changeLanguageByCode({@required LanguageCode code}) {
    switch (code) {
      case LanguageCode.English:
        changeLanguage(EnglishLanguage());
        break;
      case LanguageCode.VietNam:
        changeLanguage(VietNamLanguage());
        break;
    }
  }
}
