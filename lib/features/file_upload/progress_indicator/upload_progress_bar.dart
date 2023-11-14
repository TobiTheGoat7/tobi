import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:outt/features/common/text_widgets.dart';

class UploadProgressBar extends StatelessWidget {
  final double? progress;
  final double? width;
  final double? height;
  const UploadProgressBar({
    super.key,
    required this.progress,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width ?? 300.0.w,
        height: height ?? 75.0.h,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: LiquidLinearProgressIndicator(
          value: progress ?? 0.5,
          backgroundColor: Colors.white.withOpacity(0.5),
          valueColor: const AlwaysStoppedAnimation(Colors.blue),
          borderRadius: 12.0,
          center: NormalText(
            progress == null
                ? 'Uploading...'
                : "${((progress ?? 0.5) * 100).toStringAsFixed(2)}%",
            textColor: Colors.lightBlueAccent,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
