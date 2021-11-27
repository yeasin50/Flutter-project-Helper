import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
/// `get camera from main`
import 'package:dartAdvanced/main.dart';

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    // get from init apps
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Column(
      children: [
        AspectRatio(
            aspectRatio:
            controller.value.aspectRatio,
            child: CameraPreview(controller)),
            IconButton(icon: Icon(Icons.camera,), onPressed: () {  },)
      ],
    );
  }
}