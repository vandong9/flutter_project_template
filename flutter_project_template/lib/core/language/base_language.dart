enum LanguageCode {
  English,
  VietNam,
}

abstract class BaseLanguage {
  // Onboarding
  String filePath;

  GeneralBase generalBase;
  String codeName() => "s";
}

abstract class GeneralBase {
  String get ok => 'OK';
  String get cancel => 'Cancel';
  String get yes => 'YES';
  String get no => 'NO';
}
