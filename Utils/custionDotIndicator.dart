import 'package:flutter/material.dart';
import 'package:hodomojo/views/large_image_view_popUp/components/configs.dart';
import 'package:hodomojo/views/large_image_view_popUp/components/single_dot.widget.dart';
import 'dart:math' as math;

import 'package:scroll_to_index/scroll_to_index.dart';

class AutoHorixTest extends StatefulWidget {
  AutoHorixTest({Key? key}) : super(key: key);

  @override
  _AutoHorixTestState createState() => _AutoHorixTestState();
}

class _AutoHorixTestState extends State<AutoHorixTest> {
  static const maxCount = 10;
  final random = math.Random();
  final scrollDirection = Axis.horizontal;

  late AutoScrollController controller;
  late List<Widget> items;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, 0),
        axis: scrollDirection);
  }

  double currentIndex = 1;

  Future _scrollToIndex() async {
    print("on call $currentIndex");
    await controller.scrollToIndex(
      currentIndex.toInt(),
      preferPosition: AutoScrollPosition.middle,
    );
    controller.highlight(currentIndex.toInt());
  }

  /// * Dots' Size config
  configDotSize(int indexOfListview) {
    if (indexOfListview == currentIndex.toInt())
      return getDotSize;
    else if (currentIndex.toInt() - 1 == indexOfListview ||
        currentIndex.toInt() + 1 == indexOfListview)
      return getDotSizeNext;
    else if (currentIndex.toInt() - 2 == indexOfListview ||
        currentIndex.toInt() + 2 == indexOfListview)
      return getDotSizeFar;
    else
      return getDotSize * .3;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.cyanAccent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Auto Hori test ${currentIndex.toInt()}",
            ),
            Slider(
              min: 0,
              max: maxCount.toDouble(),
              divisions: maxCount,
              value: currentIndex.toDouble(),
              onChanged: (v) {
                setState(() {
                  currentIndex = v;
                  _scrollToIndex();
                });
              },
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              height: 40,
              width: getDotSize +
                  getDotSizeFar +
                  getDotSizeNext * 2 +
                  getRightPadding * 5,
              child: ListView.builder(
                scrollDirection: scrollDirection,
                controller: controller,
                itemCount: maxCount,
                itemBuilder: (context, index) {
                  print("rebuilding index $index onCurrectIndex $currentIndex");

                  return AutoScrollTag(
                    key: ValueKey(index),
                    controller: controller,
                    index: index,
                    child: SingleDot(
                      isActive: index == currentIndex,
                      size: configDotSize(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
