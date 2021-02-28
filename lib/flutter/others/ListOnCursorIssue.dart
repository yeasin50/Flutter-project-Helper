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
  final _textField = GlobalKey();

  //Controller
  var edit_code;
  var edit_prezzo;

  @override
  void initState() {
    super.initState();
    edit_code = new TextEditingController();
    edit_prezzo = new TextEditingController();
    edit_code.text = "cAAAAAAt";
    edit_prezzo.text = "date";
  }

  var valid = -1;

  save() {
    _textField.currentState.context;
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;

    print(h);
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: h,
        child: ListView.builder(
          itemBuilder: (ct, index) {
            final nome_piatto = "p";

            return ExpansionTile(
              title: Text("title"),
              children: [
                Container(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: edit_code,
                        // initialValue: 'your initial text',
                        onFieldSubmitted: (_) {
                          log("Submitted");
                        },
                        decoration: InputDecoration(labelText: 'Codice piatto'),
                        autofocus: false,
                      ),
                      TextFormField(
                        autofocus: false,
                        controller: edit_prezzo,
                        onFieldSubmitted: (_) {
                          log("FieldSubmit");
                        },
                        decoration: InputDecoration(labelText: 'Prezzo'),
                      ),
                      Row(
                        children: [
                          Text('Disponibile:'),
                        ],
                      )

                      //Switch(value: , onChanged: (_){})
                    ],
                  ),
                )
              ],
            );
          },
          itemCount: 34,
        ),
      ),
    ));
  }
}
