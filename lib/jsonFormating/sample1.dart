import 'dart:convert';

class User {
  String name;
  int age;

  User({required this.name, required this.age});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? "",
      age: json['age'] ?? 0,
    );
  }

  @override
  String toString() {
    return '{ $name, $age}';
  }
}

///`Json data with simple key and value`
void demo1() {
  print("Demo 1");
  String jsonString = '{"name":"Nimai", "age":43}';
  var _json = jsonDecode(jsonString);
  User user = User.fromJson(_json);
  print("Name ${user.name}");
  print("Age: ${user.age}");
}

///`Json data with key and value as List`
void demo2() {
  print("\n\ndemo 2");
  var js1 = '[{"name": "bezkoder", "age": 34}, {"name": "Aer", "age": 323}]';
  var _json1 = jsonDecode(js1) as List;

  List<User> users = _json1.map((user) => User.fromJson(user)).toList();

  users.forEach((user) {
    print("Name ${user.name}");
    print("Age: ${user.age}");
  });
}

///`Json data with key and value as List inside Tag`
void demo3() {
  print("\n\ndemo 3");
  var js2 =
      '{"Data":[{"name": "bezkoder", "age": 34}, {"name": "Aer", "age": 323}]}';

  var _json2 = jsonDecode(js2)["Data"] as List;
  List<User> users = _json2.map((user) => User.fromJson(user)).toList();

  users.forEach((element) {
    print(element.name);
    print(element.age);
  });
}

main() {
  demo1();
  demo2();
  demo3();
}
