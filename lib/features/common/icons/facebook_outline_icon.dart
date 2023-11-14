import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outt/constants/asset_strings.dart';
import 'package:outt/features/common/button_widget.dart';

class FacebookOutlineIcon extends StatelessWidget {
  final void Function()? onTap;
  const FacebookOutlineIcon({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      onTap: onTap,
      child: SvgPicture.asset(AssetStrings.facebookOutline),
    );
  }
}
