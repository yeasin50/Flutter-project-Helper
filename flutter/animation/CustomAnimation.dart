
///  create ---- ProgressIndicator
///
/// ````
/// child: SizedBox(
///    height: 12,
///    child: CustomLinearProgressIndicator(
///      backgroundColor: Colors.white,
///      color: Colors.blue,
///      maxProgressWidth: 100,
///    ),
///  ),
/// ````
class CustomLinearProgressIndicator extends StatefulWidget {
  const CustomLinearProgressIndicator({
    Key? key,
    this.color = Colors.blue,
    this.backgroundColor = Colors.white,
    this.maxProgressWidth = 100,
  }) : super(key: key);

  /// max width in center progress
  final double maxProgressWidth;

  final Color color;
  final Color backgroundColor;
  @override
  State<CustomLinearProgressIndicator> createState() =>
      _CustomLinearProgressIndicatorState();
}

class _CustomLinearProgressIndicatorState
    extends State<CustomLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 1))
        ..addListener(() {
          setState(() {});
        })
        ..repeat(reverse: true);

  late Animation animation =
      Tween<double>(begin: -1, end: 1).animate(controller);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: widget.backgroundColor,
      child: Align(
        alignment: Alignment(animation.value, 0),
        child: Container(
          decoration: ShapeDecoration(
            // play with BoxDecoration if you feel it is needed
            color: widget.color,
            shape: const StadiumBorder(),
          ),
          // you can use animatedContainer, seems not needed
          width: widget.maxProgressWidth -
              widget.maxProgressWidth * (animation.value as double).abs(),
          height: double.infinity,
        ),
      ),
    );
  }
}
