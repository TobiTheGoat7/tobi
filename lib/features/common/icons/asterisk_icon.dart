import 'package:flutter/material.dart';
import 'package:outt/constants/asset_strings.dart';
import 'package:outt/features/common/app_asset_image.dart';

class AsteriskIcon extends StatelessWidget {
  const AsteriskIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppAssetImage(
      url: AssetStrings.asterisk,
      fit: BoxFit.contain,
      color: Colors.white,
    );
  }
}
