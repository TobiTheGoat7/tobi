import 'package:outt/features/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'looping_video_widget.dart';

class OnboardingContainer extends StatelessWidget {
  final String mediaLink;
  final String contentTitle;
  final Color? contentFontColor;
  final Color? contentTitleBGColor;
  final double? width;
  final double? height;
  const OnboardingContainer({
    super.key,
    this.mediaLink = '',
    this.contentTitle = '',
    this.contentTitleBGColor,
    this.contentFontColor,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 130.0.w,
      height: height ?? 180.0.h,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0.r),
      ),
      child: Stack(
        children: [
          //Video or Image.
          if (mediaLink.endsWith('.mp4'))
            Transform.scale(
                scale: 1.5, child: LoopingVideoWidget(fileUrl: mediaLink))
          else
            Transform.scale(
              scale: 1.05,
              child: Image.asset(
                mediaLink,
                fit: BoxFit.cover,
                width: width,
                height: height,
              ),
            ),

          //Item title container
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(10.0.sp),
              margin: EdgeInsets.only(
                bottom: 12.0.sp,
              ),
              decoration: BoxDecoration(
                color: contentTitleBGColor ?? Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: NormalText(
                contentTitle,
                fontSize: 10.0,
                textColor: contentFontColor ?? Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
