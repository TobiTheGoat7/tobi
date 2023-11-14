import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/configs/navigator.dart';
import 'package:outt/constants/extensions.dart';
import 'package:outt/features/common/text_widgets.dart';
import 'package:outt/features/onboarding/app/screens/onboarding_screen.dart';
import 'package:outt/features/onboarding/app/screens/widgets/interest_grid.dart';
import 'package:outt/features/onboarding/app/screens/widgets/location_grid.dart';
import 'package:outt/features/onboarding/app/screens/widgets/profile_row.dart';
import 'package:outt/features/onboarding/app/state/select_interest_notifier.dart';
import 'package:outt/models/authentication/authenticated_user.dart';
import 'package:outt/routes.dart';

class SelectInterestScreen extends ConsumerStatefulWidget {
  ///This user object has access token
  final AuthenticatedUser user;
  static const route = ScreenPaths.selectInterestScreen;
  const SelectInterestScreen({
    super.key,
    required this.user,
  });

  @override
  ConsumerState<SelectInterestScreen> createState() =>
      _SelectInterestScreenState();
}

class _SelectInterestScreenState extends ConsumerState<SelectInterestScreen> {
  final padding = EdgeInsets.only(left: 48.0.w);

//get list of interests
//get locations

//preselect users location.

//prepare account for user.

  List<String> listOfInterests = [];
  List<String> listOfCities = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(selectInterestStateProvider.notifier).getInterestList();
      // ref.read(selectCitiesStateProvider.notifier).getCities();
    });
  }

  @override
  void dispose() {
    listOfCities = [];
    listOfInterests = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final interestState = ref.watch(selectInterestStateProvider);
    final citiesState = ref.watch(selectCitiesStateProvider);

    ref.listen(selectInterestStateProvider, (prev, next) {
      if (next is GetListOfInterestSuccess) {
        listOfInterests = next.interestList;
        setState(() {});
      } else if (next is GetListOfInterestFailure) {
        next.failure.showAlert(context);
      }
    });

    ref.listen(selectCitiesStateProvider, (prev, next) {
      if (next is GetCitiesSuccess) {
        listOfCities = next.cities;
        setState(() {});
      }
    });

    return OnboardingScaffold(
      children: [
        //
        Padding(
          padding: padding,
          child: const TitleText('Your Interest'),
        ),
        Gap(7.0.h),

        Padding(
          padding: padding,
          child: const NormalText(
            'Selecting 3 is just Okay',
            textColor: Color(0xFF757373),
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        Gap(20.0.h),
        Padding(
          padding: padding,
          child: ProfileRow(
            user: widget.user,
          ),
        ),
        Gap(46.5.h),

        ///TODO: show loading interest.
        ///
        Padding(
          padding: padding,
          child: SizedBox(
            height: 250.0.h,
            child: SingleChildScrollView(
              child: InterestGrid(
                interests: listOfInterests,
              ),
            ),
          ),
        ),
        Gap(20.0.h),
        Padding(
          padding: padding,
          child: const NormalText(
            'Set Location',
            fontSize: 12.0,
            textColor: Colors.black,
          ),
        ),

        Gap(20.0.h),

        ///TODO: show loading locations
        Padding(
          padding: padding,
          child: SizedBox(
            height: 200.0.h,
            child: SingleChildScrollView(
              child: LocationGrid(
                cities: listOfCities,
              ),
            ),
          ),
        ),
        Gap(10.0.h),
        //Explore Button
        ExploreButton(
          onTap: () {
            //TODO: make an update user interesst request
            navigateReplaceNamed(context, ScreenPaths.feedScreen);
          },
        ),
      ],
    );
  }
}

class ExploreButton extends StatelessWidget {
  final void Function()? onTap;
  const ExploreButton({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(30.0),
        onTap: onTap,
        child: SizedBox(
          width: 100.0,
          height: 44.0.h,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            NormalText(
              'Explore',
              textColor: Colors.black,
              fontSize: 12.0,
            ),

            //Forward Arrow with Shados
            Icon(
              Icons.arrow_forward,
              size: 16,
              fill: 0.8,
              shadows: [
                Shadow(offset: Offset(1, 0)),
                Shadow(offset: Offset(0, 1)),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
