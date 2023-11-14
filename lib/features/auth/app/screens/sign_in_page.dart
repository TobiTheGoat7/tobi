import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/configs/navigator.dart';
import 'package:outt/constants/asset_strings.dart';
import 'package:outt/features/auth/app/state/auth_state_notifier.dart';
import 'package:outt/features/common/button_widget.dart';
import 'package:outt/features/common/space_from_top_widget.dart';
import 'package:outt/features/common/text_widgets.dart';
import 'package:outt/features/onboarding/app/screens/onboarding_screen.dart';
import 'package:outt/models/authentication/authenticated_user.dart';
import 'package:outt/routes.dart';

class SignInScreen extends ConsumerWidget {
  static String route = ScreenPaths.signInScreen;
  const SignInScreen({super.key});

  void navigateToOnboarding(WidgetRef ref, SignInProvider provider) {
    ref.read(authStateProvider.notifier).signIn(provider: provider);
  }

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(authStateProvider, (previous, next) {
      if (next is SignInLoading) {
        navigateName(context, OnboardingScreen.route);
      } else if (next is SignInFailure) {
        //The alert is shown in OnboardingScreen
        //and Onboarding comes back here.
      }
    });

    const space = Gap(10);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 54.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SpaceFromTopWidget(),
            //
            //Tinder for Groups.
            SizedBox(
              height: 60.0.h,
            ),
            const TitleText('Outt'),

            SizedBox(
              height: 134.0.h,
            ),

            //Google SignIn Button
            SocialMediaSignInButton(
                text: 'Sign in with Google',
                icon: Image.asset(
                  AssetStrings.googleIcon,
                  scale: 1.8,
                ),
                onTap: () {
                  navigateToOnboarding(ref, SignInProvider.google);
                }),
            space,
            //Apple SignIn Button
            // SocialMediaSignInButton(
            //   text: 'Sign in with Apple',
            //   icon: Image.asset(
            //     AssetStrings.appleIcon,
            //     scale: 1.8,
            //   ),
            //   onTap: () => navigateToOnboarding(ref, SignInProvider.apple),
            // ),
            space,

            //Facebook/Instagram SignIn Button.
            // SocialMediaSignInButton(
            //   text: 'Sign in with Facebook',
            //   icon: const Icon(
            //     Icons.facebook_outlined,
            //     color: Colors.blue,
            //   ),
            //   onTap: () {
            //     navigateToOnboarding(ref, SignInProvider.facebook);
            //   },
            // ),

            space,

            // //Instagram
            // SocialMediaSignInButton(
            //   text: 'Sign in with Instagram',
            //   icon: Image.asset(
            //     AssetStrings.instagramIcon,
            //     scale: 1.8,
            //   ),
            //   onTap: () {
            //     navigateToOnboarding(ref, SignInProvider.facebook);
            //   },
            // ),

            space,

            //TODO: setup SignIn with Snapchat.
            // SocialMediaSignInButton(
            //   text: 'Sign in with Snapchat',
            //   icon: const Icon(
            //     Icons.snapchat,
            //     color: Colors.amber,
            //   ),
            //   onTap: () {
            //     navigateToOnboarding(ref, SignInProvider.facebook);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
