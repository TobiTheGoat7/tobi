import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:outt/configs/navigator.dart';
import 'package:outt/features/auth/app/screens/sign_in_page.dart';
import 'package:outt/features/home/home_page.dart';
import 'package:outt/features/onboarding/app/screens/select_interest_screen.dart';
import 'package:outt/models/authentication/authenticated_user.dart';
import 'package:outt/routes.dart';
import 'package:outt/services/authmanager/authmanager.dart';

class RootPage extends StatefulWidget {
  final AuthenticatedUser? authUser;
  const RootPage({
    super.key,
    this.authUser,
  });

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthenticatedUser?>(
      stream: AuthManager.instance.streamActiveUser(),
      builder: ((context, snapshot) {
        final user = snapshot.data;

        if (user == null &&
            (GoRouter.of(context)
                        .routerDelegate
                        .currentConfiguration
                        .uri
                        .toString() !=
                    ScreenPaths.signInScreen &&
                GoRouter.of(context)
                        .routerDelegate
                        .currentConfiguration
                        .uri
                        .toString() !=
                    ScreenPaths.onboardingScreen)) {
          Future.delayed(const Duration(milliseconds: 200), () {
            recursivePopAll(context);
          });
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: user != null
              ? (user.isNewUser ?? true)
                  ? SelectInterestScreen(user: user)
                  : const HomePage()
              : const SignInScreen(),
        );
      }),
    );
  }
}
