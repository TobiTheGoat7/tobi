import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outt/features/onboarding/app/screens/widgets/selection_box.dart';

class LocationGrid extends StatelessWidget {
  final List<String> cities;
  const LocationGrid({
    super.key,
    this.cities = const [],
  });

  @override
  Widget build(BuildContext context) {
    if (cities.isEmpty) {
      cities.addAll([
        "Victoria Island Lagos",
        "Ibadan",
        "Abuja",
        "New York",
        "Durban",
      ]);
    }
    return Wrap(
      spacing: 14.0.w,
      runSpacing: 14.0.h,
      children: cities
          .map(
            (e) => SelectionBox(e),
          )
          .toList(),
    );
  }
}
