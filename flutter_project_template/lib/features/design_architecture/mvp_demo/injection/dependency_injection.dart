import '../data/contact_data.dart';
import '../data/contact_data_mock.dart';

/// Simple DI
class Injector {
  static final Injector _singleton = Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  ContactRepository get contactRepository {
    return MockContactRepository();
  }
}
