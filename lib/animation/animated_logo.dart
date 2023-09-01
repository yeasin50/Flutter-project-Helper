import 'package:flutter/material.dart';

///mix animation with opacity, size and rotation with [AnimatedWidget]
class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({Key? key, required this.animation}) : super(key: key, listenable: animation);

  static final _opacityTween = Tween<double>(begin: 0.1, end: 1.0);
  static final _sizeTween = Tween<double>(begin: 0.0, end: 300.0);
  static final _rotateTween = Tween<double>(begin: 0.0, end: 12.0);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: _rotateTween.evaluate(animation),
        child: Opacity(
          opacity: _opacityTween.evaluate(animation),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            height: _sizeTween.evaluate(animation),
            width: _sizeTween.evaluate(animation),
            child: const FlutterLogo(),
          ),
        ),
      ),
    );
  }
}

class AnimationTest extends StatefulWidget {
  const AnimationTest({Key? key}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<AnimationTest> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInCirc);

    animation.addStatusListener(listener);
    controller.forward();
  }

  void listener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedLogo  Test'),
      ),
      body: Container(
          padding: EdgeInsets.all(32.0),
          child: AnimatedLogo(
            animation: animation,
          )),
    );
  }
}


void main(List<String> args) {
  runApp(MaterialApp(
    home: AnimationTest(),
  ));
}
