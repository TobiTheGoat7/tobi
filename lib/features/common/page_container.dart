import 'package:outt/constants/constants.dart';
import 'package:outt/features/common/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'button_widget.dart';
import 'space_from_top_widget.dart';

class PageContainer extends StatelessWidget {
  final List<Widget> children;
  final List<Widget> actionButtons;
  final String title;
  final bool hasBackButton;
  final SizedBox spaceBetweenTitleAndBody;
  final bool disablePadding;
  final void Function()? overrideBackButton;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  const PageContainer({
    super.key,
    this.children = const [],
    this.actionButtons = const [],
    this.title = '',
    this.hasBackButton = false,
    this.disablePadding = false,
    this.spaceBetweenTitleAndBody = const SizedBox(height: 50.0),
    this.overrideBackButton,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Title
            const SpaceFromTopWidget(),
            if (hasBackButton)
              Padding(
                padding: EdgeInsets.only(left: 15.0.w),
                child: AppBackButton(
                  overrideBackButton: overrideBackButton,
                ),
              ),

            if (actionButtons.isEmpty)
              Padding(
                padding: Constants.mainScreenPadding,
                child: Align(
                    alignment: Alignment.topLeft, child: TitleText(title)),
              ),

            if (actionButtons.isNotEmpty)
              Padding(
                padding: Constants.mainScreenPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                        alignment: Alignment.topLeft, child: TitleText(title)),
                    ...actionButtons
                  ],
                ),
              ),

            //Title Ends

            //Body
            Expanded(
              child: Scrollbar(
                child: Padding(
                  padding: disablePadding
                      ? EdgeInsets.zero
                      : Constants.mainScreenPadding,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        //Body
                        spaceBetweenTitleAndBody,
                        ...children,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
