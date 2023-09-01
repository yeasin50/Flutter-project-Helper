import 'package:flutter/material.dart';

class TakeCamPic extends StatefulWidget {
  TakeCamPic({Key key}) : super(key: key);

  @override
  _TakeCamPicState createState() => _TakeCamPicState();
}

class _TakeCamPicState extends State<TakeCamPic> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text("Take Picture"),
    );
  }
}