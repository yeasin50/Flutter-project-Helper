import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Vector2 {
  double dX;
  double dY;

  Vector2({
    this.dX = 0,
    this.dY = 0,
  });
}

class KeyBoardListnerTest extends StatefulWidget {
  const KeyBoardListnerTest({Key? key}) : super(key: key);

  @override
  State<KeyBoardListnerTest> createState() => _KeyBoardListnerTestState();
}

class _KeyBoardListnerTestState extends State<KeyBoardListnerTest> {
  final FocusNode focusNode = FocusNode();

  Vector2 position = Vector2();
  final double changeRate = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: rawkeyboard(),
    );
  }

  ///RawKeyboardListener is perfect for multi-keyEvent at the same time
  LayoutBuilder rawkeyboard() {
    return LayoutBuilder(
      builder: (context, constraints) => RawKeyboardListener(
        focusNode: focusNode,
        onKey: (rawKeyEvent) {
          if (rawKeyEvent is RawKeyDownEvent) {
            if (rawKeyEvent.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
              position.dX -= changeRate;

              debugPrint("KeyEvent arrowLeft");
            }
            if (rawKeyEvent.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
              position.dX += changeRate;

              debugPrint("KeyEvent arrowRight");
            }
            if (rawKeyEvent.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
              position.dY -= changeRate;
            }
            if (rawKeyEvent.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
              position.dY += changeRate;
            }

            setState(() {});
          }
        },
        child: Stack(
          children: [
            Positioned(
              left: position.dX,
              top: position.dY,
              child: Container(
                height: 30,
                width: 30,
                color: Colors.amber,
              ),
            )
          ],
        ),
      ),
    );
  }

  LayoutBuilder singleKeyEvent() {
    return LayoutBuilder(
      builder: (context, constraints) => KeyboardListener(
        focusNode: focusNode,
        onKeyEvent: (keyEvent) {
          if (keyEvent is KeyDownEvent) {
            if (keyEvent.logicalKey == LogicalKeyboardKey.arrowLeft) {
              position.dX -= changeRate;

              debugPrint("KeyEvent arrowLeft");
            }
            if (keyEvent.logicalKey == LogicalKeyboardKey.arrowRight) {
              position.dX += changeRate;

              debugPrint("KeyEvent arrowRight");
            }
            if (keyEvent.logicalKey == LogicalKeyboardKey.arrowUp) {
              position.dY -= changeRate;
            }
            if (keyEvent.logicalKey == LogicalKeyboardKey.arrowDown) {
              position.dY += changeRate;
            }
          }

          setState(() {});
        },
        child: Stack(
          children: [
            Positioned(
              left: position.dX,
              top: position.dY,
              child: Container(
                height: 30,
                width: 30,
                color: Colors.amber,
              ),
            )
          ],
        ),
      ),
    );
  }
}
