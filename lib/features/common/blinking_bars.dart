import 'package:flutter/material.dart';

class BlinkingBars extends StatefulWidget {
  const BlinkingBars({super.key});

  @override
  State<BlinkingBars> createState() => _BlinkingBarsState();
}

class _BlinkingBarsState extends State<BlinkingBars>
    with SingleTickerProviderStateMixin {
  final height = 10.0;

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: animationController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height,
              width: 140.0,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 210, 210, 210),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Container(
              height: height,
              width: 200.0,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 210, 210, 210),
                borderRadius: BorderRadius.circular(30.0),
              ),
            )
          ],
        ));
  }
}
