import 'dart:io';
import 'dart:async';

main(List<String> args) {
  String path = Directory.current.path + '/text.txt';
  print("Apending to $path");

  File file = File(path);

  Future<RandomAccessFile> f = file.open(mode: FileMode.append);
  f.then((value) {
    print("File has been openned");
    value
        .writeString("hello world")
        .then((value) => print("File has been appenned"))
        .catchError(() => print("Error occured"))
        .whenComplete(() => value.close());
  });
  print("this ocure before appending, this is future/ async");
}
