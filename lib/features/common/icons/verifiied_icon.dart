import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:outt/constants/asset_strings.dart';

class VerifiedIcon extends StatelessWidget {
  const VerifiedIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AssetStrings.verified);
  }
}
