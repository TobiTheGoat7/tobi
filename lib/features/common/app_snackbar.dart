import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///Uses the [Fluttertoast] package
///to build a custom Toast widget
///according to design specification.
class AppSnackbar {
  final BuildContext context;
  final FToast _fToast = FToast();
  final bool isError;
  AppSnackbar(
    this.context, {
    this.isError = false,
  }) {
    _fToast.init(context);
  }
  void showToast({required String text}) {
    final Size size = MediaQuery.of(context).size;
    final Widget toastWidget = Container(
      width: size.width * 0.8744,
      padding: const EdgeInsets.fromLTRB(24.0, 14.0, 24.0, 14.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: isError ? const Color(0xffFF035E) : const Color(0xFF4EA14D),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: const TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );

    _fToast.removeQueuedCustomToasts();

    _fToast.showToast(
      child: toastWidget,
      toastDuration: const Duration(seconds: 2),
      gravity: ToastGravity.TOP,
      positionedToastBuilder: (context, child) => Positioned(
        top: size.height * 0.0725,
        left: size.width * 0.0628,
        child: Center(child: child),
      ),
    );
  }
}

class AppSlidingSnackbar extends StatelessWidget {
  final String? text;
  final BuildContext context;
  const AppSlidingSnackbar(this.context, {super.key, this.text});

  void show() {
    final snackbar = SnackBar(content: Text(text ?? ''));
    // ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
