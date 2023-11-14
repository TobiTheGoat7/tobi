import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:outt/features/auth/app/screens/placeholder_log_out.dart';
import 'package:outt/features/auth/app/screens/sign_in_page.dart';
import 'package:outt/features/cliques/app/screen/cliques_detail_screen.dart';
import 'package:outt/features/create_event/app/complete_create_event_page.dart';
import 'package:outt/features/create_event/app/create_event_page.dart';
import 'package:outt/features/create_event/models/create_event_bottom_sheet_item.dart';
import 'package:outt/features/create_event/models/event_details_dto.dart';
import 'package:outt/features/event_detail/app/screen/event_detail_screen.dart';
import 'package:outt/features/feed/app/screen/feed_page.dart';
import 'package:outt/features/home/home_page.dart';
import 'package:outt/features/onboarding/app/screens/onboarding_screen.dart';
import 'package:outt/features/onboarding/app/screens/select_interest_screen.dart';
import 'package:outt/features/profile/app/screen/profile_detail_screen.dart';
import 'package:outt/models/authentication/authenticated_user.dart';
import 'package:outt/rootpage.dart';
import 'package:outt/services/authmanager/authmanager.dart';
import 'package:outt/theme.dart';

class ScreenPaths {
  static const String signInScreen = '/sign_in';
  static const String homeScreen = '/home';
  static const String onboardingScreen = '/onboarding';
  static const String selectInterestScreen = '/select_interest';
  static const String feedScreen = '/feed';
  static const String searchScreen = '/search';
  static const String accountScreen = '/account';

  static String createEventScreen = '/create_event';
  static const String completeCreateEventScreen =
      '/create_event/complete_event_creation';
  static const String eventDetailScreen = '/feed/event_detail_screen';
  static const String profileDetailScreen = '/profile_detail_screen';
  static const String cliqueDetailScreen = '/cliques_detail_screen';
}

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final heroController = MaterialApp.createMaterialHeroController();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  redirect: (context, state) async {
    final user = await AuthManager.instance.getAuthenticatedUser();

    if (user == null &&
        (state.uri.toString() != ScreenPaths.signInScreen &&
            state.uri.toString() != ScreenPaths.onboardingScreen)) {
      return "/";
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RootPage(),
    ),
    GoRoute(
      path: ScreenPaths.signInScreen,
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: ScreenPaths.onboardingScreen,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: ScreenPaths.profileDetailScreen,
      builder: (context, state) => const ProfileDetailScreen(),
    ),
    GoRoute(
      path: ScreenPaths.selectInterestScreen,
      builder: (context, state) {
        final user = state.extra as AuthenticatedUser;
        return SelectInterestScreen(
          user: user,
        );
      },
    ),
    GoRoute(
      path: ScreenPaths.cliqueDetailScreen,
      builder: (context, state) => const CliquesDetailScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        //contains just the bottom nav bar
        return Theme(
          data: theme(),
          child: HeroControllerScope(
            controller: heroController,
            child: HomePage(
              child: child,
            ),
          ),
        );
      },
      routes: [
        //Buttons of the Bottom NavBar
        //NewsFeed
        GoRoute(
          path: ScreenPaths.feedScreen,
          builder: (context, state) => const FeedScreen(),
          routes: [
            //Children of News Feed
            GoRoute(
              path: 'event_detail_screen',
              pageBuilder: (context, state) => CustomTransitionPage(
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
                child: const EventDetailScreen(),
              ),
            ),
          ],
        ),

        GoRoute(
          path: ScreenPaths.createEventScreen,
          builder: (context, state) {
            final create = state.extra as CreateEventBottomSheetItem;
            return CreateEventScreen(
              createEventBottomSheetItem: create,
            );
          },
          routes: [
            GoRoute(
              path: 'complete_event_creation',
              builder: (context, state) {
                final eventPartialDetails =
                    state.extra as EventPartialDetailsDTO;
                return CompleteCreateEventScreen(
                  eventPartialDetails: eventPartialDetails,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: ScreenPaths.searchScreen,
          builder: (context, state) => Container(),
        ),
        GoRoute(
          path: ScreenPaths.accountScreen,
          builder: (context, state) => const PlaceHolderLogOut(),
        ),
      ],
    ),
  ],
);
