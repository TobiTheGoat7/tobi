import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

///This is a custom Animated Button from Outtapp
class BlinkingElevatedButton extends StatefulWidget {
  final String? text;
  final TextStyle? style;
  final void Function()? onTap;
  final Widget? icon;
  const BlinkingElevatedButton({
    super.key,
    this.text,
    this.style,
    this.icon,
    this.onTap,
  });

  @override
  State<BlinkingElevatedButton> createState() => _BlinkingElevatedButtonState();
}

class _BlinkingElevatedButtonState extends State<BlinkingElevatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationCtrl;

  @override
  void initState() {
    super.initState();
    animationCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    animationCtrl.forward();

    animationCtrl.addListener(() {
      if (animationCtrl.isCompleted) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () {
            animationCtrl.reverse();
          },
        );
      } else if (animationCtrl.isDismissed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          animationCtrl.forward();
        });
      }
    });
  }

  @override
  void dispose() {
    animationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SlideTransition(
            position:
                Tween(begin: const Offset(0.2, 0), end: Offset.zero).animate(
              CurvedAnimation(curve: Curves.easeIn, parent: animationCtrl),
            ),
            child: Text(
              widget.text ?? "",
              style: widget.style,
            ),
          ),
          Gap(8),
          FadeTransition(
              opacity: CurvedAnimation(
                  curve: Curves.easeInOut, parent: animationCtrl),
              child: widget.icon // ?? Assets.svg.arrowRight.svg(),
              ),
        ],
      ),
    );
  }
}
