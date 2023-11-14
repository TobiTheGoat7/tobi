import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/constants/colors.dart';
import 'package:outt/features/common/button_widget.dart';
import 'package:outt/features/common/icons/verifiied_icon.dart';
import 'package:outt/features/common/profile_image_widget.dart';
import 'package:outt/features/common/text_widgets.dart';

class CuratorWidget extends StatelessWidget {
  const CuratorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const NormalText(
          "Curator",
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          textColor: AppColors.black,
        ),
        Gap(8.0.h),
        //Container With Media.
        Container(
          height: 180.0.h,
          width: 340.0.w,
          padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 25.0.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0.r),
            color: AppColors.black,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileImageWidget(
                bgColor: Colors.white,
              ),
              Gap(10.0.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      NormalText(
                        "Igwe",
                        textColor: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                      ),
                      VerifiedIcon()
                    ],
                  ),
                  const NormalText(
                    "Legend",
                    textColor: Colors.white,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),
              const Spacer(),
              AppOutlinedButton(
                width: 57,
                height: 24.0,
                fontSize: 10.0,
                text: "Follow",
                showArrow: false,
                onTap: () {},
              )
            ],
          ),
        ),

        //
      ],
    );
  }
}
