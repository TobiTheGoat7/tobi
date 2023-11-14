import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BottomSheetGreyBar extends StatelessWidget {
  const BottomSheetGreyBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(10.0.h),
        Container(
          height: 5.0,
          width: 89.0.w,
          decoration: BoxDecoration(
              color: const Color(0xFFDDDDDD),
              borderRadius: BorderRadius.circular(20.0)),
        ),
        Gap(20.0.h),
      ],
    );
  }
}
