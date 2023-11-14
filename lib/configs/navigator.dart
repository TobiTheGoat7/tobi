import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

@Deprecated("This is not a Named Route only stick with Named Routes.")
void navigateReplace(BuildContext context, Widget route,
        {bool isDialog = false}) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<dynamic>(
        fullscreenDialog: isDialog,
        builder: (BuildContext context) => route,
      ),
    );

void navigateReplaceNamed(BuildContext context, String routeName,
        {Object? args}) =>
    GoRouter.of(context).go(routeName, extra: args);

// Navigator.pushReplacementNamed(context, routeName, arguments: args);

@Deprecated("This is not a Named Route only stick with Named Routes.")
void navigate(BuildContext context, Widget route, {bool isDialog = false}) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => route,
      ),
    );

Future<void> navigateName<T>(BuildContext context, String routeName,
        {Object? args}) async =>
    GoRouter.of(context).push(routeName, extra: args);
// Navigator.pushNamed<T?>(context, routeName, arguments: args);

void recursivePopAll(BuildContext context) {
  if (GoRouter.of(context).canPop()) {
    GoRouter.of(context).pop();
    recursivePopAll(context);
  }
}

@Deprecated("This is not a Named Route only stick with Named Routes.")
void pushUntil(BuildContext context, Widget route) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute<dynamic>(builder: (BuildContext context) {
    return route;
  }), (Route<dynamic> route) => false);
}

navigatePopUntilNamedRoute(BuildContext context, String routeName) {
  if (GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString() !=
      routeName) {
    GoRouter.of(context).pop();
    navigatePopUntilNamedRoute(context, routeName);
  }

  // Navigator.popUntil(
  //   context,
  //   (route) => route.settings.name == routeName,
  // );
}

@Deprecated("Not working with GoRouter.")
void popToFirst(BuildContext context) =>
    Navigator.of(context).popUntil((route) => route.isFirst);

void navigatePop(BuildContext context) => GoRouter.of(context).pop();

//TODO: Rebuild with GoRouter
@Deprecated("Not working with GoRouter.")
class FadeRoute extends PageRouteBuilder {
  final Widget page;
  final Duration? transitionTime;
  FadeRoute({
    required this.page,
    this.transitionTime,
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );

  @override
  Duration get transitionDuration =>
      transitionTime ?? const Duration(milliseconds: 500);
}

//TODO: Rebuild with GoRouter.
@Deprecated("Not working with GoRouter.")
class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
