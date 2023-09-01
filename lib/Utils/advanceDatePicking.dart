



///* picker
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/create_trip.provider.dart';


///* provider to handle dates

final tripStartDateProvider = StateProvider<DateTime?>(
  (_) => null,
);

final tripEndDateProvider = StateProvider<DateTime?>(
  (_) => null,
);


String customDateFormat(DateTime dateTime) {
  final dateformat = DateFormat.yMMMd('en_US');
  // print(dateformat.format(dateTime));
  return dateformat.format(dateTime);
}

Future<void> onSelectDate(
    {required BuildContext context, required bool isStartDate}) async {
  final startDateNotifier = await context.read(tripStartDateProvider);
  final endDateNotifier = await context.read(tripEndDateProvider);

  DateTime selectedDate = DateTime.now();

  late DateTime firstDate;
  late DateTime initDate;
  DateTime lastDate = DateTime(2100);
  ;

  if (isStartDate) {
    lastDate =
        endDateNotifier.state != null ? endDateNotifier.state! : DateTime(2100);

    firstDate = DateTime(2000, 8);
    initDate = startDateNotifier.state != null
        ? startDateNotifier.state!
        : DateTime.now();
  } else if (!isStartDate) {
    firstDate = startDateNotifier.state != null
        ? startDateNotifier.state!
        : DateTime(2000, 8);

    initDate = endDateNotifier.state != null
        ? endDateNotifier.state!
        : firstDate.add(Duration(seconds: 1));
  }

  print("init Date ${selectedDate.toIso8601String()}");
  print("first Date ${firstDate.toIso8601String()}");

  final picked = await showDatePicker(
    context: context,
    initialDate: initDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );

  if (picked != null && picked != selectedDate) {
    if (isStartDate) {
      startDateNotifier.state = picked;
    } else {
      endDateNotifier.state = picked;
    }
  }
}
