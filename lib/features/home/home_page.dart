import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:outt/features/common/create_event_button.dart';
import 'package:outt/features/common/icons/account_icon.dart';
import 'package:outt/features/create_event/app/create_event_bottom_sheet.dart';
import 'package:outt/models/authentication/authenticated_user.dart';
import 'package:outt/routes.dart';
import 'package:outt/services/authmanager/authmanager.dart';

//
//This current design with Navigation.router exists
//because

class HomePage extends StatefulWidget {
  final Widget? child;
  const HomePage({super.key, this.child});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int get pageIndex => _locationToTabIndex(
      GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString());

  AuthenticatedUser user = AuthManager.instance.user!;

  List tabLocations = [
    ScreenPaths.feedScreen,
    //NavBar will not be navigating to this screen
    ScreenPaths.createEventScreen,
    ScreenPaths.searchScreen,
    ScreenPaths.accountScreen,
  ];

  int _locationToTabIndex(String location) {
    final index = tabLocations.indexWhere((t) => location.startsWith(t));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  // callback used to navigate to the desired tab
  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != pageIndex && tabIndex != 1) {
      // go to the initial location of the selected tab (by index)
      context.go(tabLocations[tabIndex]);
    } else if (tabIndex == 1) {
      showCreateEventBottomSheet(context);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.child == null) {
        context.go(ScreenPaths.feedScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(GoRouter.of(context)
        .routerDelegate
        .currentConfiguration
        .uri
        .toString());
    return Scaffold(
      appBar: GoRouter.of(context)
              .routerDelegate
              .currentConfiguration
              .uri
              .toString()
              .endsWith('/feed')
          ? AppBar(
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: Padding(
                padding: EdgeInsets.only(left: 30.0.w),
                child: CircleAvatar(
                  radius: 14.0.r,
                  child: ClipOval(
                    child: Image.network(
                      user.photoUrl ?? "",
                    ),
                  ),
                ),
              ),
              actions: [
                const CreateEventButton(
                  size: 40.0,
                ),
                Gap(40.0.w),
              ],
            )
          : null,
      body: widget.child ?? const SizedBox.shrink(),
      // extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        //Make the Navbar transparent.
        backgroundColor: const Color(0xDEFFFFFF),
        elevation: 0,
        currentIndex: pageIndex,
        onTap: (value) => _onItemTapped(context, value),
        type: BottomNavigationBarType.shifting,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        selectedIconTheme:
            IconThemeData(size: 20, color: Theme.of(context).primaryColor),
        unselectedIconTheme:
            const IconThemeData(size: 20.0, color: Colors.black),
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Transform.rotate(
                angle: pi / 4, child: const Icon(Icons.square_outlined)),
          ),
          const BottomNavigationBarItem(
            label: 'Create',
            icon: IgnorePointer(child: CreateEventButton()),
          ),
          const BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.search),
          ),
          const BottomNavigationBarItem(
            label: 'Account',
            icon: AccountIcon(),
          ),
        ],
      ),
    );
  }
}
