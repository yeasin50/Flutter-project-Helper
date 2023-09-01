import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


//TODO::  cant test right now
///! isolate_agents isnt supported in flutter web
import 'package:isolate_agents/isolate_agents.dart';

// our expensive task
int computationallyExpensiveTask([int value = 9999999999]) {
  var sum = 0;
  for (var i = 0; i <= value; i++) {
    sum += i;
  }
  log('finished');
  return sum;
}

Future<int> _computeTest() async {
  final result = await compute(computationallyExpensiveTask, 9999999999);
  return result;
}

final Future<Agent<int>> _agent = Agent.create(() => 0);

class BodyWidget extends StatefulWidget {
  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  int counter = 0;

  // note: isolate_agents isnt supported in flutter web
  Future<int> _testIsolateAgent() async {
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
          const CircularProgressIndicator(),
          const SizedBox(height: 10),
          Text('Counter: $counter'),
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text('Isolate Agent'),
            onPressed: () async {
              final r = await _testIsolateAgent();
              counter = r;
              setState(() {});
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text('Compute '),
            onPressed: () async {
              final r = await _computeTest();
              counter = r;
              // setState(() {});
            },
          )
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: BodyWidget()));
