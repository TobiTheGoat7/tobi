import 'package:flutter/material.dart';

class FadeInOutChild extends StatefulWidget {
  final Duration duration;
  final Widget child;
  final Curve? curve;
  const FadeInOutChild({
    super.key,
    this.duration = const Duration(seconds: 1),
    required this.child,
    this.curve = Curves.fastOutSlowIn,
  });

  @override
  State<FadeInOutChild> createState() => _FadeInOutChildState();
}

class _FadeInOutChildState extends State<FadeInOutChild>
    with SingleTickerProviderStateMixin {
  late final AnimationController fadeAnimationController;
  late final Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    fadeAnimationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    fadeAnimation =
        CurvedAnimation(parent: fadeAnimationController, curve: widget.curve!);

    fadeAnimationController.forward();
    fadeAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        fadeAnimationController
            .reverse()
            .then((value) => fadeAnimationController.forward());
      }
    });
  }

  @override
  void dispose() {
    fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: widget.child,
    );
  }
}
