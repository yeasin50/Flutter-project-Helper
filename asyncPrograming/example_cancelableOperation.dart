import 'package:async/async.dart';
 

  late Timer _timer;

  //* When user change the image by click, have delay before starting animate[_timer]
  CancelableOperation? _cancelableOperation;

  @override
  void initState() {
    _timer = _intiTimer();
  }

  Timer _intiTimer() {
    Timer timer =
        Timer.periodic(Duration(seconds: 1, milliseconds: 200), (timer) {
      setState(() {
        _index++;
        if (_index >= images.length) _index = 0;
      });
    });

    return timer;
  }

  _restartTimer() {
    if (_cancelableOperation != null) {
      _cancelableOperation!.cancel();
    }

    _cancelableOperation = CancelableOperation.fromFuture(
      Future.delayed(Duration(seconds: 3)),
    ).then(
      (p0) {
        _timer = _intiTimer();
      },
      onCancel: () {
        _timer.cancel();
      },
    );
  }
