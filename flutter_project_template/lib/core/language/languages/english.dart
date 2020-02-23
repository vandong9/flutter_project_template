import '../base_language.dart';

class EnglishLanguage extends BaseLanguage {
  GeneralBase generalBase = GeneralEnglish();
  String codeName() => "en";
}

class GeneralEnglish extends GeneralBase {
  String get ok => 'OK';
  String get cancel => 'Cancel';
  String get yes => 'YES';
  String get no => 'NO';
}
