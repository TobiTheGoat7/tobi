import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outt/features/onboarding/app/screens/widgets/selection_box.dart';

class InterestGrid extends StatelessWidget {
  final List<String> interests;
  const InterestGrid({
    super.key,
    this.interests = const [],
  });

  @override
  Widget build(BuildContext context) {
    if (interests.isEmpty) {
      interests.addAll(const [
        "Evening Chills",
        "Clubbing",
        "Beach Party",
        "Small Dinners",
        "Friends Hangout",
        "Spontaenous Events",
      ]);
    }
    return Wrap(
      spacing: 14.0.w,
      runSpacing: 14.0.h,
      children: interests
          .map(
            (e) => SelectionBox(e),
          )
          .toList(),
    );
  }
}
