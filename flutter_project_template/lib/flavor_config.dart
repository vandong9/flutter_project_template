import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum Flavor { DEV, PRODUCTION }

String flavorName(Flavor flavor) {
  switch (flavor) {
    case Flavor.DEV:
      return "DEV";
    case Flavor.PRODUCTION:
      return "PRODUCTION";
  }
  return "";
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  static FlavorConfig _instance;

  factory FlavorConfig({@required Flavor flavor, Color color: Colors.blue}) {
    _instance ??= FlavorConfig._internal(flavor, flavorName(flavor));
    return _instance;
  }

  FlavorConfig._internal(this.flavor, this.name);
  static FlavorConfig get instance {
    return _instance;
  }

  static bool isProduction() => _instance.flavor == Flavor.PRODUCTION;
  static bool isDevelopment() => _instance.flavor == Flavor.DEV;
}
