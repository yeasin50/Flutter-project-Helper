import 'package:flutter/material.dart';
import 'package:isolate_agents/isolate_agents.dart';

int computationallyExpensiveTask([int value = 9999999999]) {
  var sum = 0;
  for (var i = 0; i <= value; i++) {
    sum += i;
  }
  print('finished');
  return sum;
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BodyWidget(),
      ),
    );
  }
}

final Future<Agent<int>> _agent = Agent.create(() => 0);

class BodyWidget extends StatefulWidget {
  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  int counter = 0;

  Future<int> data() async {
    Agent<int> agent = await _agent;

    agent.update((p0) => computationallyExpensiveTask());
    return await agent.read();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(),
          ElevatedButton(
            child: Text('start $counter'),
            onPressed: () async {
              final r = await data();
              counter = r;
              setState(() {});
            },
          )
        ],
      ),
    );
  }
}
