import 'dart:developer';
import 'package:flutter/material.dart';

class CountBody extends StatefulWidget {
  CountBody({Key key}) : super(key: key);

  @override
  _CountBodyState createState() => _CountBodyState();
}

class _CountBodyState extends State<CountBody> {
  int count = 0;
  void decreaseData() {
    log("increased");
    setState(() {
      count++;
    });
  }

  Future<void> increment() async => {count++};

  Future<void> decrement() async => {count--};


  Future<String> getFutureData() async =>
      await Future.delayed(Duration(seconds: 2), () {
        return '$count';
      });

  void increaseData() {
    log("decreased");
    setState(() {
      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
                future: getFutureData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return CircularProgressIndicator();
                  if (!snapshot.hasData) return Text("Empty");
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done)
                    return Text(
                     snapshot.data.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 25,
                      ),
                    );
                }),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: increaseData,
                  child: Icon(Icons.ac_unit),
                ),
                SizedBox(
                  width: 10,
                ),
                RaisedButton(
                  onPressed: decreaseData,
                  child: Icon(
                    Icons.baby_changing_station,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
