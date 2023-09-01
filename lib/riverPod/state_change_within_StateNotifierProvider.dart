import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final intProvider = StateProvider<int>((ref) => 0);
final listProvider = StateProvider<List<int>>((ref) => []);

class UploadTest extends HookWidget {
  UploadTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final intPr = useProvider(intProvider);
    final lsPr = useProvider(listProvider);

    print(lsPr.state);
    return Center(
      child: Column(
        children: [
          Container(
            child: Text('${intPr.state} '),
          ),
          ElevatedButton(
            onPressed: () {
              context.read(intProvider).state++;
            },
            child: Text(" int PR"),
          ),
          Container(
            child: Text('${lsPr.state.length} '),
          ),
          ElevatedButton(
            onPressed: () {
              context.read(listProvider).state.add(1);
              context.read(listProvider).state =
                  context.read(listProvider).state;
            },
            child: Text(" ls PR"),
          ),
        ],
      ),
    );
  }
}
