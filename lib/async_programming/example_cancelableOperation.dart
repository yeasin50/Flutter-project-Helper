import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';

/// forgot the purpose of this file
/// but (CancelableOperation) is a good way
class CancelableTimerExample extends StatefulWidget {
  const CancelableTimerExample({super.key});

  @override
  State<CancelableTimerExample> createState() => _CancelableTimerExampleState();
}

class _CancelableTimerExampleState extends State<CancelableTimerExample> {
  int _index = 0;

  late Timer _timer;

//* When user change the image by click, have delay before starting animate[_timer]
  CancelableOperation? _cancelableOperation;

  @override
  void initState() {
    super.initState();
    _timer = _intiTimer();
  }

  Timer _intiTimer() {
    Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _index++;
        // if (_index >= images.length) _index = 0;
      });
    });

    return timer;
  }

  _restartTimer() {
    if (_cancelableOperation != null) {
      _cancelableOperation!.cancel();
    }

    _cancelableOperation = CancelableOperation.fromFuture(
      Future.delayed(const Duration(seconds: 1)),
    ).then(
      (p0) {
        _timer = _intiTimer();
      },
      onCancel: () {
        _timer.cancel();
      },
    );
  }

  pauseTimer() {
    //just cancel the timer
    // _timer.cancel();
    _cancelableOperation?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$_index"),
            ElevatedButton(
              onPressed: () {
                _timer.cancel();
              },
              child: Text("Pause Timer"),
            ),
            ElevatedButton(
              onPressed: () {
                _timer.cancel();
                _restartTimer();
              },
              child: Text("Resume Timer"),
            ),
            ElevatedButton(
              onPressed: () {
                _cancelableOperation?.cancel();
              },
              child: Text("Cancel Timer"),
            ),
          ],
        ),
      ),
    );
  }
}

void main(List<String> args) {
  runApp(MaterialApp(
    home: CancelableTimerExample(),
  ));
}
