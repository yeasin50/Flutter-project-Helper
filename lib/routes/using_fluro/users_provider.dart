import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web_test/model/user.dart';

final usersProvider =
    FutureProvider.family<User, String>((ref, username) async {
  await Future.delayed(Duration(seconds: 1));
  return _users.firstWhere((element) => element.name == username);
});

final List<User> _users = List.generate(
  10,
  (index) => User(
    id: index,
    name: "Name$index",
    age: index * 3,
  ),
);
