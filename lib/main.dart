import 'package:dartAdvanced/flutter/map/flutter_map.dart';
import 'package:flutter/material.dart';

import 'flutter/animation/animated_logo.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
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
      body: OpenStreet(),
    ));
  }
}
