import 'dart:developer';
import 'package:flutter/material.dart';

import 'countDatabase.dart';
import 'count_model.dart';
class CountBody extends StatefulWidget {
  CountBody({Key key}) : super(key: key);

  @override
  _CountBodyState createState() => _CountBodyState();
}

class _CountBodyState extends State<CountBody> {
// demo List
  // List<Count> counts = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    CDatabase.init1();
  }

  Future<void> decrement() async => {count--};
  Future<void> addModel() async {
    await Future.delayed(Duration(seconds: 1), () {
      CDatabase.insert(Count(count * 3));
    });
  }

  Future<int> getFutureDataCount() async => count;

  void increaseData() {
    log("Increased");
    setState(() {
      count++;
    });
  }

  void decreaseData() {
    log("Decreased");
    setState(() {
      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            FutureBuilder(
                future: getFutureDataCount(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return CircularProgressIndicator();
                  if (!snapshot.hasData) return Text("Empty");
                  if (snapshot.hasData)
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
                  onPressed: decreaseData,
                  child: Text("-"),
                ),
                SizedBox(
                  width: 10,
                ),
                RaisedButton(
                  onPressed: increaseData,
                  child: Text("+"),
                )
              ],
            ),

            buildFutureBuilder(),
            // demo btn for log list
          ],
        ),
      ),
    );
  }
  
  FutureBuilder<List<Count>> buildFutureBuilder() {
    return FutureBuilder(
        future: CDatabase.getCounts(), // count list
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          if (snapshot.hasData)
            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  print("on builder ${snapshot.data[index]}");
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text("${snapshot.data[index].id}"),
                    ),
                    title: Text("title ${snapshot.data[index].count}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  );
                },
              ),
            );
        });
  }
}
