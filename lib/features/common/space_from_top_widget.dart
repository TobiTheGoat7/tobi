import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpaceFromTopWidget extends StatelessWidget {
  const SpaceFromTopWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight - (Platform.isAndroid ? 9.0.h : 0),
    );
  }
}
