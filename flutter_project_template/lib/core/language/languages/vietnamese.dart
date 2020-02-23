import '../base_language.dart';

class VietNamLanguage extends BaseLanguage {
  GeneralBase generalBase = GeneralVietNamese();
  String codeName() => "vn";
}

class GeneralVietNamese extends GeneralBase {
  String get ok => 'Chấp Nhận';
  String get cancel => 'Huỷ';
  String get yes => 'CÓ';
  String get no => 'KHÔNG';
}
