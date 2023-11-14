import 'package:flutter/material.dart';
import 'package:outt/constants/asset_strings.dart';

class AccountIcon extends StatelessWidget {
  final Color? color;
  final double? size;
  const AccountIcon({
    super.key,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      const AssetImage(
        AssetStrings.userImg,
      ),
      color: color,
      size: size,
    );
  }
}
