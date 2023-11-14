import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/constants/asset_strings.dart';
import 'package:outt/constants/extensions.dart';
import 'package:outt/features/auth/app/state/auth_state_notifier.dart';
import 'package:outt/features/common/app_circular_progress_indicator.dart';
import 'package:outt/features/common/auto_animating_widget.dart';
import 'package:outt/features/common/blinking_bars.dart';
import 'package:outt/features/common/button_widget.dart';
import 'package:outt/features/common/onboarding_container.dart';
import 'package:outt/features/common/space_from_top_widget.dart';
import 'package:outt/features/common/text_widgets.dart';
import 'package:outt/routes.dart';

///this is kind of a loading screen that switches between two pages.
class OnboardingScreen extends ConsumerStatefulWidget {
  static const route = ScreenPaths.onboardingScreen;
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final boxHeight = 530.0.h;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authStateProvider, (previous, next) {
      if (next is SignInFailure) {
        next.failure.showAlert(context);
        debugPrint(next.failure.message);

        Future.delayed(
            const Duration(
              seconds: 1,
            ), () {
          Navigator.pop(context);
        });
      } else if (next is SignInSuccess) {
        //Navigation is handled by rootpage.
      }
    });

    //pageone.
    final pageOne = SizedBox(
      key: UniqueKey(),
      height: boxHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 73.0.w),
            child: const TitleText('Events'),
          ),
          Gap(34.0.h),

          ///Image Grid..
          Padding(
            padding: EdgeInsets.only(left: 57.0.w),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    OnboardingContainer(
                      contentTitle: "Lola's Party",
                      mediaLink: AssetStrings.lolaPartyAsset,
                      height: 140.0.h,
                      width: 130.0.w,
                    ),
                    Gap(10.0.w),
                    OnboardingContainer(
                      mediaLink: AssetStrings.happyDogAsset,
                      contentTitle: "Jude's Hangout",
                      contentTitleBGColor: const Color(0xFFFBBC05),
                      height: 180.0.h,
                      width: 130.0.w,
                    ),
                  ],
                ),
                Gap(15.0.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OnboardingContainer(
                      mediaLink: AssetStrings.balloonAsset,
                      contentTitle: "Balloon Party",
                      contentTitleBGColor: const Color(0xFF0BE345),
                      height: 180.0.h,
                      width: 130.0.w,
                    ),
                    Gap(10.0.w),
                    OnboardingContainer(
                      mediaLink: AssetStrings.agbadaAsset,
                      contentTitle: "Da Show",
                      height: 140.0.h,
                      width: 130.0.w,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final pageTwo = SizedBox(
      height: boxHeight,
      key: UniqueKey(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 57.0.w),
            child: const TitleText('Connect\n with friends & Vibes'),
          ),
          Gap(34.0.h),

          ///Image Grid..
          Padding(
            padding: EdgeInsets.only(left: 57.0.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    OnboardingContainer(
                      contentTitle: "Nengi's CA. Meet",
                      mediaLink: AssetStrings.nengiImageOneAsset,
                      height: 201.0.h,
                      width: 130.0.w,
                    ),
                    Gap(11.0.h),
                    OnboardingContainer(
                      mediaLink: AssetStrings.chiFoodAsset,
                      contentTitle: "Chef Chi's eat out",
                      contentFontColor: Colors.white,
                      contentTitleBGColor: const Color(0xFFEA354B),
                      height: 208.0.h,
                      width: 130.0.w,
                    ),
                  ],
                ),
                Gap(13.0.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    OnboardingContainer(
                      mediaLink: AssetStrings.nengiImageTwoAsset,
                      contentTitle: "Nengi's CA. Meet",
                      contentTitleBGColor: const Color(0xFF0BE345),
                      height: 146.0.h,
                      width: 130.0.w,
                    ),
                    Gap(16.0.h),
                    OnboardingContainer(
                      mediaLink: AssetStrings.asakeAsset,
                      contentTitle: "Asake @ Sluggers",
                      height: 208.0.h,
                      width: 130.0.w,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    List<Widget> children = [
      AutoAnimate(
        children: [
          pageOne,
          pageTwo,
        ],
      ),
      Gap(10.0.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          BlinkingBars(),
        ],
      ),
      const Padding(
        padding: EdgeInsets.all(32.0),
        child: AppCircularProgressIndicator(),
      ),
      Gap(10.0.h),
      AutoAnimate(
        children: [
          Row(
            key: UniqueKey(),
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              NormalText(
                'Signing you up',
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                textColor: Color(0xFF858585),
              ),
            ],
          ),
          Row(
            key: UniqueKey(),
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              NormalText(
                'Verifying your profile',
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                textColor: Color(0xFF858585),
              ),
            ],
          ),
        ],
      ),
      Gap(50.0.h),
    ];

    return OnboardingScaffold(
      children: children,
    );
  }
}

class OnboardingScaffold extends StatelessWidget {
  final List<Widget> children;
  const OnboardingScaffold({
    super.key,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SpaceFromTopWidget(),
            const AppBackButton(),
            Gap(40.0.h),
            ...children
          ],
        ),
      ),
    );
  }
}
