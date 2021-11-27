import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// we can also write it on singleLine
final uploadTaskProvider = StateNotifierProvider((ref) => UploadTaskNotifier());

class UploadTaskNotifier extends StateNotifier<List<bool>> {
  UploadTaskNotifier() : super([]);

  update(value) {
    state.add(value);
    state = state;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

final tripRepositoryProvider = ChangeNotifierProvider<Temp>((ref) {
  return Temp(ref.read);
});

class Temp with ChangeNotifier {
  final Reader reader;
  Temp(this.reader);

  clear() {
    final pr = reader(uploadTaskProvider.notifier);
    pr.state = [];
  }

  startUploading() {
    final pr = reader(uploadTaskProvider.notifier);
    pr.update(true);
  }
}


///widgets
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'upload/editTrip.provider.dart';

class UploadTest extends HookWidget {
  UploadTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final intPr = useProvider(uploadTaskProvider);

    return Center(
      child: Column(
        children: [
          Text('${intPr.length} '),
          ElevatedButton(
            onPressed: () {
              context.read(tripRepositoryProvider).startUploading();
            },
            child: Text(" int PR"),
          ),
          ElevatedButton(
            onPressed: () {
              context.read(tripRepositoryProvider).clear();
            },
            child: Text(" Clear PR"),
          ),
        ],
      ),
    );
  }
}

