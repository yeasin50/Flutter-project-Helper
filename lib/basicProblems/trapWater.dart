import 'dart:math';

int findTotalWater(arr, n) {
  int totalWater = 0;

  /// 1st and last index can't contain water
  for (int i = 1; i < n - 1; i++) {
    int leffMax = findLeftMax(arr, n, i);
    int rightMax = findRightMax(arr, n, i);

    totalWater += min(leffMax, rightMax) - arr[i];
  }
  return totalWater;
}

int findLeftMax(arr, n, i) {
  int maximum = 0;
  for (int j = 0; j <= i; j++) {
    maximum = max(maximum, arr[j]);
  }
  return maximum;
}

int findRightMax(arr, n, i) {
  int maximum = 0;
  for (int j = n - 1; j >= i; j--) {
    maximum = max(maximum, arr[j]);
  }
  return maximum;
}

main(List<String> args) {
  var arr = [4,2,0,3,2,5];
  print(findTotalWater(arr, arr.length)); //9
}
