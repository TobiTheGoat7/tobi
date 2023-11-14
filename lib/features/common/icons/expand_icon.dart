import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outt/constants/asset_strings.dart';

class AppExpandIcon extends StatelessWidget {
  const AppExpandIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AssetStrings.expandIcon);
  }
}
