import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/constants/colors.dart';
import 'package:outt/features/cliques/app/screen/widgets/curator_widget.dart';
import 'package:outt/features/cliques/app/screen/widgets/ride_hailing_widget.dart';
import 'package:outt/features/common/app_animated_button.dart';
import 'package:outt/features/common/button_widget.dart';
import 'package:outt/features/common/clique_item_box_long.dart';
import 'package:outt/features/common/text_widgets.dart';

class CliquesDetailScreen extends StatelessWidget {
  const CliquesDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 16.0.w,
        title: const TitleText(
          "Sam & Friends",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(30.h),
              const TitleText(
                "Asake IB Over Take",
              ),
              const NormalText(
                "13k+  70+ Clique",
                textColor: AppColors.titleFontColor,
              ),
              Gap(24.0.h),
              const CliqueItemBoxLong(),
              Gap(10.0.h),
              const CuratorWidget(),
              Gap(10.0.h),
              const AppAnimatedButton(),
              Gap(10.0.h),
              AppIconButton(
                borderRadius: 50.0.r,
                width: 321.0.w,
                height: 46.0.h,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      NormalText(
                        "Nope I want to go Solo",
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                        textColor: AppColors.black,
                      ),
                      Gap(10.0),
                      Icon(
                        Icons.arrow_forward,
                      ),
                    ]),
                onTap: () {},
              ),
              Gap(40.0.h),
              const RideHailingWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
