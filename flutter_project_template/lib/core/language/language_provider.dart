import 'package:flutter/material.dart';
import 'app_localization.dart';
import 'languages/base.dart';
import 'languages/en.dart';
import 'languages/vn.dart';

class LanguageProvider extends ChangeNotifier {
  Base _currentLanguage;
  LanguageCode _currentLanguageCode;

  LanguageProvider() {
    _currentLanguage = Vn();
    _currentLanguageCode = LanguageCode.VietNam;
  }

  Base get language => _currentLanguage;
  LanguageCode get languageCode => _currentLanguageCode;
  void changeLanguage(Base newLangauge, LanguageCode code) {
    print("Dong: change to language $code");
    _currentLanguageCode = code;
    _currentLanguage = newLangauge;
    notifyListeners();
  }

  void changeLanguageByCode({@required LanguageCode code}) {
    switch (code) {
      case LanguageCode.English:
        changeLanguage(En(), code);
        break;
      case LanguageCode.VietNam:
        changeLanguage(Vn(), code);
        break;
    }
  }
}
