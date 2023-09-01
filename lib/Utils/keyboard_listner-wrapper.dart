import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef OnMovement = void Function();

class KeyBoardListnerWrapper extends StatelessWidget {
  KeyBoardListnerWrapper({
    Key? key,
    required this.child,
    required this.onDown,
    required this.onUp,
    required this.onLeft,
    required this.onRight,
  }) : super(key: key);

  final FocusNode focusNode = FocusNode();
  final Widget child;
  final OnMovement onDown;
  final OnMovement onUp;
  final OnMovement onLeft;
  final OnMovement onRight;

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: focusNode,
      onKey: (rawKeyEvent) {
        if (rawKeyEvent is RawKeyDownEvent) {
          if (rawKeyEvent.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
            onLeft();
          }
          if (rawKeyEvent.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
            onRight();
          }
          if (rawKeyEvent.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
            onUp();
          }
          if (rawKeyEvent.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
            onDown();
          }
        }
      },
      child: child,
    );
  }
}
