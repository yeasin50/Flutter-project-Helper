//* Still learning🤣
class CustomScrollPhysics extends ScrollPhysics {
  const CustomScrollPhysics({required ScrollPhysics parent})
      : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(parent: buildParent(ancestor)!);
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    return BouncingScrollSimulation(
      position: position.pixels,
      velocity: velocity,
      tolerance: tolerance,
      leadingExtent: 0,
      trailingExtent: 0,
      spring: SpringDescription.withDampingRatio(
        mass: 50,
        stiffness: 50,
        ratio: 1,
      ),
    );
  }
}
