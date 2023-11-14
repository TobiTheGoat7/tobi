import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outt/features/common/text_widgets.dart';

///This is a custom Animated Button for Outtapp
class AppAnimatedButton extends StatefulWidget {
  final String? text;
  final void Function()? onTap;
  const AppAnimatedButton({
    super.key,
    this.text,
    this.onTap,
  });

  @override
  State<AppAnimatedButton> createState() => _AppAnimatedButtonState();
}

class _AppAnimatedButtonState extends State<AppAnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationCtrl;

  Color black = Colors.black;

  Color blue = const Color(0xFF0C78F8);

  Color green = const Color(0xFF4BED65);

  ///We animate the colors of the gradient independently.
  late Animatable<Color?> colorOne;
  late Animatable<Color?> colorTwo;

  ///We animate the opacity of the arrows using doubles for better precision.
  late Animatable<double?> arrowOpacity;

  @override
  void initState() {
    super.initState();
    animationCtrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..repeat();
    colorOne = TweenSequence<Color?>([
      TweenSequenceItem(
          weight: 1.0, tween: ColorTween(begin: black, end: blue)),
      TweenSequenceItem(weight: 5.0, tween: ColorTween(begin: blue, end: blue)),
      TweenSequenceItem(weight: 5.0, tween: ColorTween(begin: blue, end: black))
    ]);
    colorTwo = TweenSequence<Color?>([
      TweenSequenceItem(
          weight: 1.0, tween: ColorTween(begin: black, end: black)),
      TweenSequenceItem(
          weight: 5.0, tween: ColorTween(begin: black, end: green)),
      TweenSequenceItem(
          weight: 5.0, tween: ColorTween(begin: green, end: black)),
    ]);
    arrowOpacity = TweenSequence<double?>([
      TweenSequenceItem(weight: 1.0, tween: Tween<double>(begin: 0, end: 0)),
      TweenSequenceItem(weight: 5.0, tween: Tween<double>(begin: 0, end: 1)),
      TweenSequenceItem(weight: 5.0, tween: Tween<double>(begin: 1, end: -1)),
    ]);
  }

  @override
  void dispose() {
    animationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationCtrl,
      builder: (context, _) {
        return GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: 321.0.w,
            height: 46.0.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0.r),
              gradient: LinearGradient(
                colors: [
                  colorOne.evaluate(
                          AlwaysStoppedAnimation(animationCtrl.value)) ??
                      Colors.black,
                  colorTwo.evaluate(
                          AlwaysStoppedAnimation(animationCtrl.value)) ??
                      Colors.black,
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSlide(
                  duration: const Duration(milliseconds: 300),
                  offset: (arrowOpacity.evaluate(AlwaysStoppedAnimation(
                                  animationCtrl.value)) ??
                              0) >
                          0.4
                      ? const Offset(-0.05, 0)
                      : Offset.zero,
                  child: NormalText(
                    widget.text ?? "Request to Join",
                    textColor: Colors.white,
                  ),
                ),
                Visibility(
                  visible: (arrowOpacity.evaluate(AlwaysStoppedAnimation(
                                  animationCtrl.value)) ??
                              0) >
                          0.4
                      ? true
                      : false,
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
