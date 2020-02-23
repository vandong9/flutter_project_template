import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_template/core/routes/navigation.dart';

import 'redux/redux_sample_count_page.dart';

class StateManagementSamplesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("State Management"),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
              onPressed: () {
                push(context, ReduxSampleCountPage());
              },
              child: Text("Redux Count Example"))
        ],
      ),
    );
  }
}
