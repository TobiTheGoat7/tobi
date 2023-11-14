import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/configs/navigator.dart';
import 'package:outt/constants/colors.dart';
import 'package:outt/features/common/icons/verifiied_icon.dart';
import 'package:outt/features/common/text_widgets.dart';
import 'package:outt/routes.dart';

class ProfileEventListTile extends StatelessWidget {
  const ProfileEventListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 318.0.w,
      height: 332.0.h,
      child: Material(
        borderRadius: BorderRadius.circular(25.0.r),
        color: AppColors.black,
        child: InkWell(
          borderRadius: BorderRadius.circular(25.0.r),
          onTap: () {
            navigateName(context, ScreenPaths.eventDetailScreen);
          },
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 6.0.h),
                  decoration: BoxDecoration(
                    color: AppColors.white.withAlpha(200),
                    borderRadius: BorderRadius.circular(30.0.r),
                  ),
                  child: const NormalText("2 Days Ago"),
                ),
              ),
              const Spacer(),
              Row(
                children: const [
                  NormalText("Lola's Dinner"),
                  Gap(10.0),
                  VerifiedIcon(),
                ],
              ),
              Row(
                children: const [
                  NormalText("Lola's Dinner"),
                ],
              ),
              Row(
                children: const [
                  NormalText("Allen Avenue"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const NormalText("View"),
                  ),
                  Row(
                    children: const [NormalText("6 in  2 left")],
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
