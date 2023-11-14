import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/constants/asset_strings.dart';
import 'package:outt/features/common/text_widgets.dart';

class FailedToGetHappeningNow extends StatelessWidget {
  const FailedToGetHappeningNow({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0.h,
        width: 345.0.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xFFFFF8E5),
        ),
        child: Row(children: [
          Gap(30.0.w),
          Image.asset(
            AssetStrings.frownImg,
            height: 40.0.w,
            width: 40.0.w,
          ),
          Gap(20.0.w),
          const NormalText(
            'We could not find events \nin your city or cities near you.',
            maxLines: 2,
            fontSize: 13.0,
            textColor: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ]),
      ),
    );
  }
}
