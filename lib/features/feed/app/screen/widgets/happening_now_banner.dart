import 'package:outt/constants/asset_strings.dart';
import 'package:outt/features/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HappeningNowBanner extends StatefulWidget {
  //This banner show be an in app banner from cloud messaging.
  const HappeningNowBanner({super.key});

  @override
  State<HappeningNowBanner> createState() => _HappeningNowBannerState();
}

class _HappeningNowBannerState extends State<HappeningNowBanner> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0.h,
        width: 345.0.w,
        padding: EdgeInsets.only(top: 20.0.h, left: 20.0.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.black,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                NormalText(
                  'Happening Now 🎉✨',
                  textColor: Colors.white,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                ),
                Gap(12.0),
                NormalText(
                  'Lagos Loves Damini',
                  textColor: Colors.white,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(4.0),
                const NormalText(
                  'in 35mins',
                  textColor: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
                const Gap(17.0),
                Image.asset(
                  AssetStrings.burnaImg,
                  width: 90.0.w,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
            const Gap(30.0),
          ],
        ),
      ),
    );
  }
}
