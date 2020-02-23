import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UIControlPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UIControlPageState();
}

class _UIControlPageState extends State<UIControlPage> {
  @override
  Widget build(BuildContext context) {
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
