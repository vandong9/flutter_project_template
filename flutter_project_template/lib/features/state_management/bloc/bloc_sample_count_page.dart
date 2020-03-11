import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 1, Create class extend Bloc<Event, State>
// 2, Wrap class in  BlocProvider > BlockBuilder
// 3, When invoke "context.bloc<BlocSubClass>()", this should be in the lower level
// compare to BlocProvider in tree

class BlocSampleCountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => _CounterBloc(),
        child: BlocBuilder<_CounterBloc, int>(builder: (_, count) {
          return Scaffold(
            appBar: AppBar(title: Text("Bloc Sample Counter")),
            body: Column(
              children: <Widget>[
                Text("$count"),
                // This FlatButton because it wrapped in other widget mean it in lower level tree
                AddButton(),
                // This FlatButton not work due to it in same level with BlocProvider
                FlatButton(
                    onPressed: () {
                      context.bloc<_CounterBloc>().add(_CounterEvent.increment);
                    },
                    child: Text("Add not work"))
              ],
            ),
            // This FlatButton not work due to it in same level with BlocProvider
            floatingActionButton: FloatingActionButton(onPressed: () {
              context.bloc<_CounterBloc>().add(_CounterEvent.increment);
            }),
          );
        }));
  }
}

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
          onPressed: () {
            context.bloc<_CounterBloc>().add(_CounterEvent.increment);
          },
          child: Text("Add OK")),
    );
  }
}

enum _CounterEvent { increment, decrement }

class _CounterBloc extends Bloc<_CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(_CounterEvent event) async* {
    switch (event) {
      case _CounterEvent.decrement:
        yield state - 1;
        break;
      case _CounterEvent.increment:
        yield state + 1;
        break;
    }
  }
}
