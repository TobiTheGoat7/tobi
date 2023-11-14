import 'package:flutter/material.dart';

class AutoAnimate extends StatefulWidget {
  final List<Widget> children;
  final Curve? curve;
  final int secondsPerChild;
  const AutoAnimate({
    super.key,
    required this.children,
    this.curve = Curves.fastOutSlowIn,
    this.secondsPerChild = 2,
  });

  @override
  State<AutoAnimate> createState() => _AutoAnimateState();
}

class _AutoAnimateState extends State<AutoAnimate>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<int> animation;
  int currentPage = 0;

  List<Widget> children = [];

  @override
  void initState() {
    super.initState();
    children = widget.children;

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: children.length * widget.secondsPerChild),
    );

    animation = IntTween(begin: 0, end: children.length - 1)
        .animate(animationController)
      ..addListener(() {
        setState(() {});
      });

    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return AnimatedSizeAndFade(
    //   child: children[animation.value],
    // );
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: children[animation.value],
    );

    // return FadeInOutChild(
    //   curve: widget.curve,
    //   duration: Duration(
    //       milliseconds:
    //           ((widget.secondsPerChild / widget.children.length) * 1000)
    //               .toInt()),
    //   child: children[animation.value],
    // );
  }
}

class AnimatedSizeAndFade extends StatelessWidget {
  static final _key = UniqueKey();

  final Duration fadeDuration;
  final Duration sizeDuration;
  final Curve fadeInCurve;
  final Curve fadeOutCurve;
  final Curve sizeCurve;
  final Alignment alignment;
  final bool show;
  final Widget? child;

  const AnimatedSizeAndFade({
    Key? key,
    this.fadeDuration = const Duration(milliseconds: 500),
    this.sizeDuration = const Duration(milliseconds: 500),
    this.fadeInCurve = Curves.easeInOut,
    this.fadeOutCurve = Curves.easeInOut,
    this.sizeCurve = Curves.easeInOut,
    this.alignment = Alignment.center,
    this.child,
  })  : show = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var animatedSize = AnimatedSize(
      duration: sizeDuration,
      curve: sizeCurve,
      child: AnimatedSwitcher(
        duration: fadeDuration,
        switchInCurve: fadeInCurve,
        switchOutCurve: fadeOutCurve,
        layoutBuilder: _layoutBuilder,
        child: show
            ? child
            : SizedBox(
                key: AnimatedSizeAndFade._key,
                width: double.infinity,
                height: 0,
              ),
      ),
    );

    return ClipRect(child: animatedSize);
  }

  Widget _layoutBuilder(Widget? currentChild, List<Widget> previousChildren) {
    List<Widget> children = previousChildren;

    if (currentChild != null) {
      if (previousChildren.isEmpty) {
        children = [currentChild];
      } else {
        children = [
          Positioned(
            left: 0.0,
            right: 0.0,
            child: Container(child: previousChildren[0]),
          ),
          Container(child: currentChild),
        ];
      }
    }

    return Stack(
      clipBehavior: Clip.none,
      alignment: alignment,
      children: children,
    );
  }
}
