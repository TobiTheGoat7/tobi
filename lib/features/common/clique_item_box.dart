import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/configs/navigator.dart';
import 'package:outt/constants/colors.dart';
import 'package:outt/features/common/profile_image_widget.dart';
import 'package:outt/features/common/text_widgets.dart';
import 'package:outt/routes.dart';

///Takes a list of cliques and shows an avatar with that.
class CliqueItemBox extends StatelessWidget {
  const CliqueItemBox({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateName(context, ScreenPaths.cliqueDetailScreen);
      },
      child: Container(
        width: 156.w,
        height: 185.h,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ProfileImageWidget(),
                ProfileImageWidget(),
              ],
            ),
            Gap(10.0.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ProfileImageWidget(),
                ProfileImageWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
