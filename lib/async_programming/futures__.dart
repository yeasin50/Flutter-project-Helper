import 'dart:developer';
import 'dart:io';
import 'dart:async';

/// run as dart lib/async_programming/futures__.dart
main(List<String> args) {
  const currentDIR = 'lib/async_programming';
  String path = '${Directory.current.path}/$currentDIR/text.txt';
  // String path = Directory.current.path + '/text.txt';
  print("Appending to $path");

  File file = File(path);

  Future<RandomAccessFile> f = file.open(mode: FileMode.append);
  f.then((value) {
    log("File has been opened");
    value
        .writeString("hello world")
        .then((value) => log("File has been appended"))
        .catchError(
          () => log("Error occurred"),
        )
        .whenComplete(() => value.close());
  });
  log("this occurs before appending, this is future/ async");

  ///! A common mistake is using `await` and `then` together
  ///! `await` is used to wait for a future to complete
  ///! `then` is used to register a callback that will be called when the future completes
}
