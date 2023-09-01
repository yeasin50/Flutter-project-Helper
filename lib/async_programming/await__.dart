import 'dart:async';
import 'dart:io';

Future<File> appendFile() {
  // by default, the file is created if it does not exist
  // the the (Directory.current.path) is the folder where the app is running
  File file = File("${Directory.current.path}/lib/async_programming/text2.txt");
  DateTime now = DateTime.now();
  return file.writeAsString("${now.toString()} \r\n", mode: FileMode.append);
}

/// just run this file with `dart lib/async_programming/await__.dart`
main(List<String> args) async {
  print("starting...");
  File file = await appendFile();

  print("Appended to file ${file.path}");
  print("END....");
}
