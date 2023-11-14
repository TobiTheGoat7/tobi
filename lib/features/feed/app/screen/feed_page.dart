import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/constants/extensions.dart';
import 'package:outt/features/common/app_animated_button.dart';
import 'package:outt/features/common/icons/orange_icon.dart';
import 'package:outt/features/common/text_widgets.dart';
import 'package:outt/features/feed/app/screen/widgets/feed_tile.dart';
import 'package:outt/features/feed/app/screen/widgets/happening_now_banner.dart';
import 'package:outt/features/feed/app/state/feed_state_notifier.dart';

import 'widgets/failed_to_get_happening_now_widget.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FeedBody(),
    );
  }
}

class FeedBody extends ConsumerStatefulWidget {
  const FeedBody({super.key});

  @override
  ConsumerState<FeedBody> createState() => _FeedBodyState();
}

class _FeedBodyState extends ConsumerState<FeedBody> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(feedStateNotifierProvider);

    ref.listen<FeedState>(feedStateNotifierProvider, (previous, next) {
      if (next is FeedFailure) {
        next.failure.showAlert(context);
      }
    });

    return ListView(
      cacheExtent: 200,
      padding: EdgeInsets.symmetric(horizontal: 30.0.w),
      children: [
        const Gap(20.0),
        if (state is FeedFailure) const FailedToGetHappeningNow(),
        const Gap(20.0),
        if (state is FeedLoading)
          const Center(child: CircularProgressIndicator()),
        if (state is FeedSuccess) ...[
          const HappeningNowBanner(),
          const Gap(20.0),
          Hero(
            tag: 'feed-button',
            child: Center(
              child: AppAnimatedButton(
                text: "Create yours",
                onTap: () {},
              ),
            ),
          ),
          const Gap(20.0),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                NormalText(
                  'Popping in the world ',
                  fontSize: 20.0,
                  textColor: Colors.black,
                ),
                Gap(10),
                OrangeIcon(),
              ],
            ),
          ),
          const Gap(20.0),
          ...List.generate(
            state.eventFeedData.length,
            (index) => FeedTile(
              eventFeedData: state.eventFeedData[index],
            ),
          ),
        ],
      ],
    );
  }
}
