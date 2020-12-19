import 'dart:convert';
import 'dart:io';

//depend on OS
void communicating_processes() {
  //Windows specific
  Process.start('C:\\Windows\\System32\\cmd.exe', []).then((Process process) {
    //Listen for output from the process
    process.stdout.transform(utf8.decoder).listen((data) {
      print(data);

      //Kill the process after we got the response we wanted
      if (data.contains("Hello World")) {
        Process.killPid(process.pid);
      }
    });

    //get the exit code from the process
    process.exitCode.then((int code) {
      print('Exit code: ${code}');
      //exit
      exit(0);
    });

    //Send to the process
    process.stdin.writeln('ECHO "Hello World"');

    //Don't do this you are killing the process before it can respond
    //Process.killPid(process.pid);
  });
}

void listOfDir() {
  //List of all files in a directory
  /// `some windows may not have this command `
  Process.run('ls', ['-l']).then((preocessResult) {
    print(preocessResult.stdout);
    print("Exit code: ${preocessResult.exitCode}");
  });
}

main() {
  listOfDir();
  communicating_processes();
}
