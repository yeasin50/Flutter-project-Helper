import 'package:flutter/material.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';

class CheckUP extends StatefulWidget {
  @override
  _CheckUPState createState() => _CheckUPState();
}

final people = <Person>[Person('Alice', '123 Main'), Person('Bob', '456 Main')];

class Person {
  late String name, address;
  Person(this.name, this.address);
}

final letters = 'abcdefghijklmnopqrstuvwxyz'.split('');
final List<String> names = ["yeasi", 'yeas', 'sehikg', '123asd', "asd"];

class _CheckUPState extends State<CheckUP> {
  String? selectedLetter;
  Person? selectedPerson;

  final formKey = GlobalKey<FormState>();
  bool autovalidate = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
        autovalidateMode:
            autovalidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: ListView(children: <Widget>[
          SizedBox(height: 16.0),
          Text('Selected person: "$selectedPerson"'),
          Text('Selected letter: "$selectedLetter"'),
          SizedBox(height: 16.0),
          SimpleAutocompleteFormField<Person>(
            decoration: InputDecoration(
                labelText: 'Person', border: OutlineInputBorder()),
            suggestionsHeight: 80.0,
            itemBuilder: (context, person) => Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(person!.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(person.address)
                  ]),
            ),
            onSearch: (search) async => people
                .where((person) =>
                    person.name.toLowerCase().contains(search.toLowerCase()) ||
                    person.address.toLowerCase().contains(search.toLowerCase()))
                .toList(),
            itemFromString: (string) {
              final matches = people.where((person) =>
                  person.name.toLowerCase() == string.toLowerCase());
              return matches.isEmpty ? null : matches.first;
            },
            onChanged: (value) => setState(() => selectedPerson = value),
            onSaved: (value) => setState(() => selectedPerson = value),
            validator: (person) => person == null ? 'Invalid person.' : null,
          ),
          SizedBox(height: 16.0),
          SimpleAutocompleteFormField<String>(
            decoration: InputDecoration(
                labelText: 'Letter', border: OutlineInputBorder()),
            // suggestionsHeight: 200.0,
            maxSuggestions: 10,
            itemBuilder: (context, item) => Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(item!),
            ),
            onSearch: (String search) async => search.isEmpty
                ? letters
                : letters
                    .where((letter) => search.toLowerCase().contains(letter))
                    .toList(),
            itemFromString: (string) => letters.singleWhere(
                (letter) => letter == string.toLowerCase(),
                orElse: () => ''),
            onChanged: (value) => setState(() => selectedLetter = value),
            onSaved: (value) => setState(() => selectedLetter = value),
            validator: (letter) => letter == null ? 'Invalid letter.' : null,
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  formKey.currentState!.save();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Fields valid!')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Fix errors to continue.')));
                  setState(() => autovalidate = true);
                }
              }),
          
          //TODO:: Focus 
          SimpleAutocompleteFormField<String>(
            // decoration: InputDecoration(
            //     labelText: 'Receiver name', border: OutlineInputBorder()),
            // suggestionsHeight: 200.0,
            maxSuggestions: 10,
            itemBuilder: (context, item) => Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(item!),
            ),
            onSearch: (String search) async => names
                .where(
                    (name) => name.toLowerCase().contains(search.toLowerCase()))
                .toList(),
            // itemFromString: (string) => letters.singleWhere(
            //     (letter) => letter == string.toLowerCase(),
            //     orElse: () => ''),
            onChanged: (value) => setState(() => selectedLetter = value),
            onSaved: (value) => setState(() => selectedLetter = value),
            validator: (letter) => letter == null ? 'Invalid letter.' : null,
          ),
        ]),
      ),
    );
  }
}
