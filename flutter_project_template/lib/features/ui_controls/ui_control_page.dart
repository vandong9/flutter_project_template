import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_template/core/language/app_localization.dart';
import 'package:project_template/core/language/index.dart';
import 'package:provider/provider.dart';

class UIControlPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UIControlPageState();
}

class _UIControlPageState extends State<UIControlPage> {
  @override
  Widget build(BuildContext context) {
    LanguageProvider language = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("UI Controls"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Text("Label/Text"), Text("This is static text")],
          ),
          Row(
            children: <Widget>[
              Text("Button"),
              CupertinoButton(
                  child: Text("Click me"),
                  onPressed: () {
                    _neverSatisfied(context);
                  })
            ],
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: language.languageCode == LanguageCode.VietNam,
                onChanged: (isChecked) {
                  if (isChecked) {
                    language.changeLanguageByCode(code: LanguageCode.VietNam);
                  } else {
                    language.changeLanguageByCode(code: LanguageCode.English);
                  }
                },
              ),
              Text(language.languageCode == LanguageCode.VietNam ? "vn" : "en"),
              Text(language.language.state_Management_Samples)
            ],
          )
        ],
      ),
    );
  }
}

Future<void> _neverSatisfied(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('This is alert'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is alert content'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
