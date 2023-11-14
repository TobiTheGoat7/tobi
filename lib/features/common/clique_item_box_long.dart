import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/constants/colors.dart';
import 'package:outt/features/common/icons/expand_icon.dart';
import 'package:outt/features/common/profile_image_widget.dart';
import 'package:outt/features/common/text_widgets.dart';

class CliqueItemBoxLong extends StatelessWidget {
  const CliqueItemBoxLong({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF1EFEF),
              borderRadius: BorderRadius.circular(20.0.r),
            ),
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    NormalText(
                      "Sam & Friends",
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      textColor: AppColors.black,
                    ),
                    NormalText(
                      "12 in",
                      fontSize: 10.0,
                      fontWeight: FontWeight.w400,
                      textColor: Color(0xFF0BE345),
                    ),
                  ],
                ),
                Gap(10.0.h),
                //Probably have to use a wrap here instead.
                Wrap(
                  runSpacing: 10.0.h,
                  spacing: 10.0.w,
                  children: const [
                    ProfileImageWidget(),
                    ProfileImageWidget(),
                    ProfileImageWidget(),
                    ProfileImageWidget(),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Gap(4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            AppExpandIcon(),
            NormalText(
              "meet people in clique",
              fontSize: 10.0,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ],
    );
  }
}
