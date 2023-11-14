import 'package:flutter/material.dart';
import 'package:outt/features/common/text_widgets.dart';

class RideHailingWidget extends StatelessWidget {
  const RideHailingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NormalText("Location"),
        //Address
        NormalText("4, Nugwe Avenue, Matt Rd. Enugu, Enugu."),
      ],
    );
  }
}
