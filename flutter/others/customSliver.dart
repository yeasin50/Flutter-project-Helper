
///https://api.flutter.dev/flutter/rendering/RenderSliver-class.html

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            FooSliver(
              child: Text("Hi From Foo sliver"),
            ),
            BarSliver2()
          ],
        ),
      ),
    );
  }
}

class BarSliver2 extends SingleChildRenderObjectWidget {
  const BarSliver2({super.key, super.child = const Text("Hello from Bar")});

  @override
  RenderObject createRenderObject(BuildContext context) => FooRenderSliver();
}

class FooSliver extends SingleChildRenderObjectWidget {
  const FooSliver({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) => FooRenderSliver();
}

class FooRenderSliver extends RenderSliverSingleBoxAdapter {
  FooRenderSliver({super.child});

  @override
  void performLayout() {
    /// from  [RenderSliverToBoxAdapter]
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    final SliverConstraints constraints = this.constraints;
    child!.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    final double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child!.size.width;
        break;
      case Axis.vertical:
        childExtent = child!.size.height;
        break;
    }
    assert(childExtent != null);
    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: childExtent);
    final double cacheExtent =
        calculateCacheOffset(constraints, from: 0.0, to: childExtent);

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxPaintExtent: childExtent,
      hitTestExtent: paintedChildSize,
      hasVisualOverflow: childExtent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );
    setChildParentData(child!, constraints, geometry!);
  }
}
