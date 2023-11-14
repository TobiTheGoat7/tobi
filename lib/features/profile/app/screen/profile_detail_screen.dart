import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/constants/colors.dart';
import 'package:outt/features/common/button_widget.dart';
import 'package:outt/features/common/icons/facebook_outline_icon.dart';
import 'package:outt/features/common/icons/instagram_outline_icon.dart';
import 'package:outt/features/common/icons/twitter_icon.dart';
import 'package:outt/features/common/icons/verifiied_icon.dart';
import 'package:outt/features/common/profile_image_widget.dart';
import 'package:outt/features/common/text_widgets.dart';
import 'package:outt/features/profile/app/screen/widgets/profile_event_box.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      const ProfileImageWidget(),
                      const Gap(11),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          NormalText(
                            "Igwe",
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            textColor: AppColors.black,
                          ),
                          NormalText(
                            "Legend",
                            fontSize: 10.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      const Spacer(),
                      const VerifiedIcon(),
                    ],
                  ),
                  const Gap(15.0),
                  Row(
                    children: const [
                      NormalText("50 Events"),
                      Gap(12.0),
                      NormalText("2.4M Followers"),
                      Gap(12.0),
                      NormalText("300 Visits"),
                    ],
                  ),
                  const Gap(15.0),
                  const NormalText(
                    "Love having fun fridays only hosting the live parties every friday",
                    maxLines: 4,
                  ),
                  const Gap(15.0),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: NormalText("Fun . Night Out . Hangout")),
                  const Gap(25.0),
                  Row(
                    children: [
                      InstagramOutlineIcon(
                        onTap: () {},
                      ),
                      FacebookOutlineIcon(
                        onTap: () {},
                      ),
                      TwitterOutlineIcon(
                        onTap: () {},
                      ),
                      const Spacer(),
                      AppOutlinedButton(
                        text: "Following",
                        showArrow: false,
                        width: 170.0.w,
                        onTap: () {},
                      )
                    ],
                  ),
                ],
              ),
            ),
            Gap(40.0.h),
            Center(
              child: Container(
                width: 340.0.w,
                height: 180.0.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: AppColors.black,
                ),
              ),
            ),
            Gap(40.0.h),
            Padding(
              padding: EdgeInsets.only(left: 40.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const NormalText("Cliq"),
                  Gap(19.0.h),
                  SizedBox(
                    height: 70,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 8.0.w),
                        itemBuilder: (context, index) {
                          return const Center(
                            child: ProfileImageWidget(),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Gap(40.0.h),
            Padding(
              padding: EdgeInsets.only(left: 40.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const NormalText("Events"),
                  Gap(24.0.h),
                  SizedBox(
                    height: 340,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 20.0.w),
                        itemBuilder: (context, index) {
                          return const Center(
                            child: ProfileEventListTile(),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
