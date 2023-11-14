import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outt/configs/navigator.dart';
import 'package:outt/routes.dart';

class ProfileImageWidget extends StatelessWidget {
  final Color? bgColor;
  const ProfileImageWidget({super.key, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12.0.r),
      color: bgColor ?? Colors.black,
      child: InkWell(
        onTap: () {
          navigateName(context, ScreenPaths.profileDetailScreen);
        },
        child: Container(
          height: 60.h,
          width: 60.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0.r),
          ),
        ),
      ),
    );
  }
}
