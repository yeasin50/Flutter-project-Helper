import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  String validator(String value) {
    if (value.isEmpty)
      return "Empty 😫";
    else if (value.isEmpty || !value.contains('@')) {
      return 'Enter a valid email';
    } else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        offset: Offset(0, 1),
                        color: Colors.blue,
                      )
                    ]),
                child: TextFormField(
                  validator: validator,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, otherwise false.
                  if (_formKey.currentState.validate()) {
                    log("Process further ");
                  }
                },
                child: Text("submit"),
              ),
            ]),
      ),
    ));
  }
}
