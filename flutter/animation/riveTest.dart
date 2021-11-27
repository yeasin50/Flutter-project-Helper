import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class RiveTest extends StatefulWidget {
  RiveTest({Key key}) : super(key: key);

  @override
  _RiveTestState createState() => _RiveTestState();
}

class _RiveTestState extends State<RiveTest>
    with SingleTickerProviderStateMixin {
  void _togglePlay() {
    setState(() => _controller.isActive = !_controller.isActive);
  }

  /// Tracks if the animation is playing by whether controller is running.
  bool get isPlaying => _controller?.isActive ?? false;

  Artboard _riveArtboard;
  RiveAnimationController _controller;

  @override
  void initState() {
    super.initState();

    loadRives();
    // rootBundle.load("assets/rive/aircraft.riv").then((data) async {
    //   final file = RiveFile();
    //   if (file.import(data)) {
    //     final artboard = file.artboardByName("shipBoard");

    //     artboard.addController(_controller = SimpleAnimation("playing"));
    //     setState(() {
    //       _riveArtboard = artboard;
    //     });
    //   }
    // });
  }

  void loadRives() async {
    final bytes = await rootBundle.load("assets/rive/aircraft.riv");
    final file = RiveFile();

    if (file.import(bytes)) {
      setState(() => _riveArtboard = file.artboardByName("shipBoard")
        ..addController(SimpleAnimation("playing")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            height: 200,
            // width: 400,
            child: _riveArtboard == null
                ? const Text("Didn't found")
                : AspectRatio(
                  aspectRatio: 1,
                    child: Rive(
                      artboard: _riveArtboard,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
        RaisedButton(
          onPressed: _togglePlay,
          child: isPlaying ? Text("Pause") : Text("PLay"),
        ),
      ],
    );
  }
}
