import 'package:flutter/material.dart';
import 'package:outt/constants/asset_strings.dart';

class OrangeIcon extends StatelessWidget {
  const OrangeIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetStrings.citrusImg,
      height: 16,
      width: 16,
    );
  }
}
