import 'package:flutter/material.dart';
import 'package:outt/constants/asset_strings.dart';

class GoogleText extends StatelessWidget {
  const GoogleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetStrings.googleImg,
      height: 10,
    );
  }
}
