import 'package:camera/camera.dart';
import 'package:dartAdvanced/flutter/map/flutter_map.dart';
import 'package:dartAdvanced/flutter/phone_integration/camera/camera_widget.dart';
import 'package:dartAdvanced/flutter/phone_integration/contact_service.dart';
import 'package:dartAdvanced/flutter/phone_integration/permission_handler.dart';
import 'package:dartAdvanced/flutter/phone_integration/url_launcher_.dart';
import 'package:flutter/material.dart';

import 'flutter/animation/animated_logo.dart';

/// `for camera, this is under development, maybe later I'll add save funtion`
/// `For just Taking picture we can use image_picker https://pub.dev/packages/image_picker `
List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(new MaterialApp(
    home: MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      // body: AnimWidget(),
      // body: OpenStreet(),
      // body: UrlLuncher(),
      // body: PermissionHandler(),
      // body: ContactService(),
      body: CameraApp(),
    ));
  }
}
