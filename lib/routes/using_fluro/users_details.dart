import 'package:flutter/material.dart';
import 'package:web_test/model/user.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_test/providers/users_provider.dart';

class UserDetails extends StatefulWidget {
  final String? userName;

  UserDetails({Key? key, this.userName}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check user info "),
      ),
      body: Container(
        child: Consumer(
          builder: (context, watch, child) {
            final userResponse = watch(usersProvider(widget.userName!));

            return userResponse.map(
              data: (value) => Text(
                "${value.value.name}",
              ),
              loading: (value) => CircularProgressIndicator(),
              error: (value) => Text("ERR"),
            );
          },
        ),
      ),
    );
  }
}
