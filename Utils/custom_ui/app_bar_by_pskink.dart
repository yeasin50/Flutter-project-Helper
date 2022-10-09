
/// author > https://stackoverflow.com/users/2252830/pskink
class FooShapeBorderTest extends StatefulWidget {
  @override
  State<FooShapeBorderTest> createState() => _FooShapeBorderTestState();
}

class _FooShapeBorderTestState extends State<FooShapeBorderTest> {
  double left = 0;
  double elevation = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: FooShapeBorder(left: left),
        elevation: elevation,
        leading: const Icon(Icons.animation),
        title: Text('left: $left, elevation: $elevation'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => setState(() {
            // timeDilation = 10;
            left = left == 0 ? 100 : 0;
            elevation = elevation == 2 ? 6 : 2;
          }),
          child: const Text('press me'),
        ),
      ),
    );
  }
}

class FooShapeBorder extends ShapeBorder {
  const FooShapeBorder({
    required this.left,
  });

  final double left;

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is FooShapeBorder) {
      return FooShapeBorder(
        left: ui.lerpDouble(a.left, left, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  ui.Path getInnerPath(ui.Rect rect, {ui.TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  ui.Path getOuterPath(ui.Rect rect, {ui.TextDirection? textDirection}) {
    const radius = Radius.circular(16);
    final rrect =
        RRect.fromRectAndCorners(rect, bottomLeft: radius, bottomRight: radius);
    final points = [
      const Offset(0, 0),
      Offset(rect.height, -rect.height),
      Offset(rect.height + 10, -rect.height),
      const Offset(10, 0),
    ];
    final middlePath = Path()..addPolygon(points, true);
    return Path()
      ..addRRect(rrect)
      ..fillType = PathFillType.evenOdd
      ..addPath(middlePath, rect.bottomLeft.translate(left + 16, 0));
  }

  @override
  void paint(ui.Canvas canvas, ui.Rect rect,
      {ui.TextDirection? textDirection}) {
    final r = rect.bottomLeft.translate(left + 16 + 10, 0) & const Size(64, 4);
    canvas.drawRect(r, Paint()..color = Colors.orange);
  }

  @override
  ShapeBorder scale(double t) => this;
}
