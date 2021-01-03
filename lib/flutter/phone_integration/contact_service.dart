import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactService extends StatefulWidget {
  ContactService({Key key}) : super(key: key);

  @override
  _ContactServiceState createState() => _ContactServiceState();
}

class _ContactServiceState extends State<ContactService> {
  @override
  void initState() {
    super.initState();

    /// ` àsk permission on first app launch `
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _wrapContactsAction(() {});
    });
  }

// get permission like in looking
  Future<void> _wrapContactsAction(Function action) async {
    final isGranted = await Permission.contacts.isGranted;
    if (isGranted) {
      action();
    } else {
      final permStatus = await Permission.contacts.request();
      if (permStatus.isGranted) {
        action();
      }
    }
  }

// Checking the permission then performing actions
  void _findContact() {
    _wrapContactsAction(() async {
      Iterable<Contact> contacts =
          await ContactsService.getContacts(query: "yeasin");
      showInSnackbar('There are ${contacts.length} contact named yeasin');
    });
  }

  void _readContact() {
    _wrapContactsAction(() async {
      Iterable<Contact> people =
          await ContactsService.getContacts(query: 'yeasin');
      if (people.isNotEmpty) {
        Contact contact = people.first;
        showInSnackbar('yeasin email is ${contact.emails.first.value}');
      } else {
        showInSnackbar('NO Email not found');
      }
    });
  }

  void _deleteContact() {
    _wrapContactsAction(() async {
      Iterable<Contact> people =
          await ContactsService.getContacts(query: 'yeasin');
      if (people.isNotEmpty) {
        Contact contact = people.first;
        await ContactsService.deleteContact(contact);
        showInSnackbar('yeasin deleted');
      } else {
        showInSnackbar('yeasin not found');
      }
    });
  }

  void _addContact() async {
    _wrapContactsAction(() async {
      Contact contact = Contact(
          familyName: "Sheikh",
          givenName: "yeasin",
          emails: [Item(label: 'personal', value: "yeasinsheikh50@gmail.com")]);
      await ContactsService.addContact(contact);
    });
  }

  void showInSnackbar(String message) {
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        content: Text(message),
      ),
    );
    log(message);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100,
              child: Text(
                "${1}",
                style: TextStyle(fontSize: 23),
              ),
            ),
            RaisedButton(
              onPressed: _addContact,
              child: Text("Add Contact"),
            ),
            RaisedButton(
              onPressed: _readContact,
              child: Text("read contact"),
            ),
            RaisedButton(
              onPressed: _findContact,
              child: Text("find Contact"),
            ),
            RaisedButton(
              onPressed: _deleteContact,
              child: Text("delete Contact"),
            ),
            RaisedButton(
              onPressed: openAppSettings,
              child: Text("Open Settings later"),
            ),
          ],
        ),
      ),
    );
  }
}
