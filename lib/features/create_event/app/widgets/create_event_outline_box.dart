import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/features/common/text_widgets.dart';

class CreateEventOutlineBox extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? child;
  const CreateEventOutlineBox({
    super.key,
    this.child,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF938E8E),
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              NormalText(
                title ?? '',
                fontWeight: FontWeight.w700,
                fontSize: 11.0,
              ),
              Gap(80.0.w),
              NormalText(
                subtitle ?? '',
                fontSize: 7.0,
                fontWeight: FontWeight.w700,
                textColor: const Color(0xFF938E8E),
              ),
            ],
          ),
          const Gap(5.0),
          child ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
