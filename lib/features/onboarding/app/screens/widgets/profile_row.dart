import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/constants/asset_strings.dart';
import 'package:outt/features/common/text_widgets.dart';
import 'package:outt/models/authentication/authenticated_user.dart';

class ProfileRow extends StatelessWidget {
  final AuthenticatedUser user;
  const ProfileRow({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.0.w,
      child: Row(
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.black,
            ),
            child: Image.network(user.photoUrl ?? ''),
          ),
          Gap(19.0.w),
          NormalText(
            (user.name ?? '').trim(),
            fontWeight: FontWeight.w500,
            fontSize: 10.0,
          ),
          const Spacer(),
          Image.asset(
            determineProviderAsset(user.signInProvider),
            scale: 1.8,
          ),
        ],
      ),
    );
  }
}

String determineProviderAsset(SignInProvider provider) {
  String assetString;
  if (provider == SignInProvider.google) {
    assetString = AssetStrings.googleIcon;
  } else if (provider == SignInProvider.facebook) {
    assetString = AssetStrings.instagramIcon;
  } else if (provider == SignInProvider.apple) {
    assetString = AssetStrings.appleIcon;
  } else if (provider == SignInProvider.twitter) {
    assetString = AssetStrings.googleIcon;
  } else {
    assetString = AssetStrings.googleIcon;
  }
  return assetString;
}
