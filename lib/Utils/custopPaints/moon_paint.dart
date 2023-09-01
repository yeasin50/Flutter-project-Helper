//imperfect 


class MoonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;

    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0XFF8134AF),
          Color(0XFFDD2A7B),
          // Color(0XFFFEDA77),
          // Color(0XFFF58529),
        ],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));

    final p0 = Offset(size.width * .45, 0);
    final p1 = Offset(0, size.height * .65);

    Path path = Path()
      ..moveTo(p0.dx, p0.dy)
      ..arcToPoint(
        p1,
        largeArc: true,
        radius: Radius.circular(width / 2),
      )
      ..arcToPoint(
        p0,
        clockwise: false,
        largeArc: true,
        radius: Radius.circular(width * .7),
      );

    canvas.drawPath(
      path,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MoonPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Color(0XFF8134AF),
          Color(0XFFDD2A7B),
          Color(0XFFFEDA77),
          Color(0XFFF58529),
        ],
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));

    Path path1 = Path()
      ..addOval(Rect.fromCenter(
          center: center, width: size.width, height: size.height));

    Path path2 = Path()
      ..addOval(
        Rect.fromCenter(
          center: Offset(
            center.dx - 10,
            center.dy - 10,
          ),
          width: size.width - 10,
          height: size.height - 10,
        ),
      );
    canvas.drawPath(
      Path.combine(PathOperation.difference, path1, path2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
