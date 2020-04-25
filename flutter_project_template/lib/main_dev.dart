import 'package:firebase_analytics/observer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project_template/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import './core/theme/theme.dart' as theme;
import 'package:flutter/material.dart';
import 'core/language/index.dart';
import 'flavor_config.dart';
import 'routers.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

// Run app
void main() {
  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  FlavorConfig(flavor: Flavor.DEV, color: Colors.deepPurpleAccent);
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider<theme.ThemeProvider>.value(value: ThemeProvider(theme.ThemeType.light)), ChangeNotifierProvider<LanguageProvider>.value(value: LanguageProvider())],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('vn', 'VI'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LanguageProvider language = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Samples"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  pushToStateManagementSamplePage(context);
                },
                child: Text(language.language.state_Management_Samples),
              )
            ],
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  pushToDesignPatternSamplesPage(context);
                },
                child: Text(language.language.design_Pattern_Samples),
              )
            ],
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  pushReplaceToUIControlPage(context);
                },
                child: Text(language.language.ui_Controls_Samples),
              )
            ],
          ),
        ],
      ),
    );
  }
}
