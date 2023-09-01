
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ModeType {
  happy,
  sad,
  joy,
  hmm,
}

class Mode extends StateNotifier<ModeType> {
  Mode() : super(ModeType.hmm);

  void happy() => state = ModeType.happy;
  void sad() => state = ModeType.sad;
  void joy() => state = ModeType.joy;
  void hmm() => state = ModeType.hmm;

  @override
  void dispose() {
    super.dispose();
  }
}

final modeProvider = StateNotifierProvider((ref) => Mode());

// ignore: must_be_immutable
class StateNTest extends ConsumerWidget {
  int count = 0;
  int buildN = 0;
  @override
  Widget build(BuildContext context, watch) {
    final modeNotifier = watch(modeProvider);

    print("build ${buildN++}");
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Current Mode: $modeNotifier",
          ),
          if (modeNotifier == ModeType.sad) Text("Count Sad: ${count++}"),
          OutlinedButton(
            onPressed: () => context.read(modeProvider.notifier).happy(),
            child: Text("Happy"),
          ),
          OutlinedButton(
            onPressed: () => context.read(modeProvider.notifier).sad(),
            child: Text("sad"),
          ),
          OutlinedButton(
            onPressed: () => context.read(modeProvider.notifier).joy(),
            child: Text("Joy"),
          ),
          OutlinedButton(
            onPressed: () => context.read(modeProvider.notifier).hmm(),
            child: Text("Hmm"),
          ),
        ],
      ),
    );
  }
}
