import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import './core/language/language.dart';
import './core/theme/theme.dart' as theme;
import 'package:flutter/material.dart';
import 'flavor_config.dart';
import 'global_providers.dart';
import 'routers.dart';

// Run app
void main() {
  FlavorConfig(flavor: Flavor.PRODUCTION, color: Colors.deepPurpleAccent);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<theme.ThemeProvider>.value(value: themeProvider),
      ChangeNotifierProvider<LanguageProvider>.value(value: languageProvider)
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
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
                child: Text("State Management Samples"),
              )
            ],
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  pushToDesignPatternSamplesPage(context);
                },
                child: Text("Design Pattern Samples"),
              )
            ],
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  pushReplaceToUIControlPage(context);
                },
                child: Text("UI Controls Samples"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
