import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/configs/navigator.dart';
import 'package:outt/constants/asset_strings.dart';
import 'package:outt/constants/extensions.dart';
import 'package:outt/features/common/cached_video_widget.dart';
import 'package:outt/features/common/image_from_file.dart';
import 'package:outt/features/common/text_widgets.dart';
import 'package:outt/features/feed/models/event.dart';
import 'package:outt/routes.dart';

class FeedTile extends StatelessWidget {
  final EventFeedData eventFeedData;
  const FeedTile({
    super.key,
    required this.eventFeedData,
  });

  @override
  Widget build(BuildContext context) {
    final eventName = eventFeedData.name;
    final eventVideoUrl = eventFeedData.videoUrl;
    final host = eventFeedData.eventCreator?.name ?? '';
    final hostLogoUrl = eventFeedData.eventCreator?.profilePicture ?? '';
    final eventCapacity = eventFeedData.peopleAttending;
    final eventLocation = eventFeedData.location;
    final ticketGoing = eventFeedData.peopleJoined.toString();
    final ticketLeft = eventFeedData.peopleLeft.toString();

    //?This width caclulation can be a performance bottleneck
    final eventNameWidth = measureTextSize(
        eventName ?? '',
        const TextStyle(
          fontSize: 24.0,
        )).width;

    //
    return Center(
      child: GestureDetector(
        onTap: () {
          navigateName(context, ScreenPaths.eventDetailScreen);
        },
        child: SizedBox(
          // height: 430.0.h,
          width: 345.0.w,
          child: Column(
            children: [
              Container(
                height: 332.0.h,
                width: 345.0.w,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    stops: [0, 0.5],
                    colors: [
                      Colors.black54,
                      Colors.black12,
                    ],
                  ),
                ),
                child: CachedVideoWidget(videoUrl: eventVideoUrl),
              ),
              const Gap(10.0),
              Column(
                children: [
                  //
                  Row(
                    children: [
                      SizedBox(
                        width: eventNameWidth > 330.w ? 330.w : eventNameWidth,
                        child: NormalText(
                          eventName,
                          fontSize: 24.0.sp,
                          maxLines: 2,
                          textColor: Colors.black,
                        ),
                      ),
                      const Gap(10.0),
                      Image.asset(
                        AssetStrings.verifiedImg,
                        height: 20.0,
                        width: 20.0,
                      ),
                      const Spacer(),
                      const Icon(Icons.grid_3x3),
                    ],
                  ),
                  const Gap(4.0),
                  //
                  Row(
                    children: [
                      Container(
                        height: 23.0,
                        width: 23.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.black),
                        child: AppCachedImageWidget(imageUrl: hostLogoUrl),
                      ),
                      const Gap(4.0),
                      NormalText(
                        host,
                        fontSize: 14.0,
                        textColor: Colors.black,
                      ),
                      const Gap(4.0),
                      NormalText(
                        '$eventCapacity Persons Event',
                        fontSize: 14.0,
                      )
                    ],
                  ),

                  const Gap(4.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: NormalText(
                          eventLocation,
                          fontSize: 10.0,
                          textColor: const Color(0xFF757373),
                        ),
                      ),
                      Row(
                        children: [
                          NormalText(
                            '$ticketGoing in',
                            fontSize: 10.0,
                            textColor: const Color(0xFF0BE345),
                          ),
                          const Gap(4.0),
                          NormalText(
                            '$ticketLeft left',
                            fontSize: 10.0,
                            textColor: const Color(0xFFEA4335),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Gap(4.0),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: NormalText(
                      'Join',
                      textColor: Colors.blue,
                    ),
                  ),
                  const Gap(8.0),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
