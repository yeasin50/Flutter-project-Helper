import 'dart:async';
import 'dart:io';

Future<File> appendFile() {
  File file = File(Directory.current.path + "/text2.txt");
  DateTime now = DateTime.now();
  return file.writeAsString(now.toString() + "\r\n", mode: FileMode.append);
}

main(List<String> args) async {
  print("starting...");
  File file = await appendFile();

  print("Appended to file ${file.path}");
  print("END....");
}
