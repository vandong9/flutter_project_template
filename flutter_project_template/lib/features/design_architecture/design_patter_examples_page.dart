import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_template/core/routes/navigation.dart';

import 'mvp_demo/presenter/contact_view.dart';
import './mvvm_demo/ui/home/home_page.dart';

class DesignPatternExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Design Pattern Examples')),
      body: Column(
        children: <Widget>[
          FlatButton(
              onPressed: () {
                push(context, ContactsPage());
              },
              child: Text("MVP Example")),
          FlatButton(
              onPressed: () {
                push(context, HomePage());
              },
              child: Text("MVVM Example"))
        ],
      ),
    );
  }
}
