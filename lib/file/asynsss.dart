import 'dart:io';

void main(List<String> arguments) {
  print('Start.....');
  var path = Directory.current.path + '\\test.txt',
      content = DateTime.now().toString() + '\r\n';

  print('---Append file---');
  appendFile(path, content);

  print('---read file---');
  var file = File(path);
  file.readAsString();
  print(file);
}

Future<File> appendFile(String path, String content) {
  var file = File(path);

  return file.writeAsString(content, mode: FileMode.append);
}