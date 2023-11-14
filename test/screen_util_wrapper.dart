import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outt/constants/constants.dart';

///This is used to wrap widgets with screen utils so tests
///can work efficiently.
Widget wrapWithScreenUtil(Widget widget) {
  return MaterialApp(
    home: ScreenUtilInit(
      designSize: const Size(
        Constants.designWidth,
        Constants.designHeight,
      ),
      builder: (context, child) {
        return widget;
      },
      child: widget,
    ),
  );
}
