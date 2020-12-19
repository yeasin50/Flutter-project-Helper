import 'dart:io';

main() {
  print('OS:${Platform.operatingSystem} ${Platform.version}');

  if (Platform.isWindows) {
    print("hola, Window");
  } else {
    print(Platform.operatingSystem);
  }

  var path = Platform.script.path;
  print('current file Path: ${path}');
  print('dart: ${Platform.executable}');

  print("Env");
  Platform.environment.keys.forEach((key) {
    print("$key: ${Platform.environment[key]}");
  });
}
