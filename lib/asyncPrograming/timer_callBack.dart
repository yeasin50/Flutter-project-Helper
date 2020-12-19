import 'dart:async';

int counter = 0;

String getTime() {
  DateTime dateTime = DateTime.now();
  return dateTime.toString();
}

void timeOut(Timer timer) {
  print("timeout :${getTime()}");

  counter < 6 ? counter++ : timer.cancel();
}

main(List<String> args) {
  print(getTime());
  Duration duration = Duration(seconds: 1);
  Timer timer = Timer.periodic(duration, timeOut);
}
