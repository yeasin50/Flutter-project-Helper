main(List<String> args) {
  var arr = [1, 2, 3, 4, 5, 6, 7];
  var d = 2;
  int n = 7;

  // hold in temp array
  var temp = [d];
  for (int i = 0; i < d; i++) {
    temp[i] = arr[i];
  }

  // swap the d amount values
  for (int i = 0; i < n - d; i++) {
    arr[i] = arr[i + d];
  }

  // initialize the temp
  for (int i = n; i > n - d; i--) {
    arr[i - 1] = temp[i - n + 1];
    print(">> i = $i =   ${i - n + 1}");
  }
  print("temp $temp");
  print("arr  $arr");
}
