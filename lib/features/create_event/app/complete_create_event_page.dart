import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/configs/navigator.dart';
import 'package:outt/constants/constants.dart';
import 'package:outt/constants/extensions.dart';
import 'package:outt/features/common/app_snackbar.dart';
import 'package:outt/features/common/app_video_widget.dart';
import 'package:outt/features/common/button_widget.dart';
import 'package:outt/features/common/icons/google_text.dart';
import 'package:outt/features/common/icons/orange_icon.dart';
import 'package:outt/features/common/text_widgets.dart';
import 'package:outt/features/create_event/app/state/create_event_state_notifier.dart';
import 'package:outt/features/create_event/app/widgets/add_more_photos_boxes.dart';
import 'package:outt/features/create_event/app/widgets/create_event_date_widget.dart';
import 'package:outt/features/create_event/app/widgets/event_access_selector.dart';
import 'package:outt/features/create_event/models/event_access.dart';
import 'package:outt/features/create_event/models/event_details_dto.dart';
import 'package:outt/features/create_event/models/event_details_full_dto.dart';
import 'package:outt/routes.dart';

class CompleteCreateEventScreen extends ConsumerStatefulWidget {
  static const route = ScreenPaths.completeCreateEventScreen;
  final EventPartialDetailsDTO eventPartialDetails;
  const CompleteCreateEventScreen({
    super.key,
    required this.eventPartialDetails,
  });

  @override
  ConsumerState<CompleteCreateEventScreen> createState() =>
      _CompleteCreateEventScreenState();
}

class _CompleteCreateEventScreenState
    extends ConsumerState<CompleteCreateEventScreen> {
  List<String> selectedImageUrls = [];
  EventAccess? eventAccess;

  void completeEventCreationProcess() {
    if (eventAccess == null) {
      AppSnackbar(context, isError: true)
          .showToast(text: "Please select Access");
    } else if (selectedImageUrls.isEmpty) {
      AppSnackbar(context, isError: true).showToast(text: "Please add Images ");
    } else {
      EventFullDetailsDTO data = EventFullDetailsDTO(
          eventPartialDetailsDTO: widget.eventPartialDetails,
          imageUrls: selectedImageUrls,
          eventAccess: eventAccess ?? EventAccess('0', 0));

      ref.read(createEventStateNotifierProvider.notifier).createEventFull(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createEventStateNotifierProvider);

    ref.listen(createEventStateNotifierProvider, (previous, next) {
      if (next is CreateEventFailure) {
        next.failure.showAlert(context);
      } else if (next is CreateEventSuccess) {
        navigateName(context, ScreenPaths.feedScreen);
      }
    });
    const greyFontColor = Color(0xFF444242);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: Constants.appLeadingWidth,
        title: Row(
          children: const [
            TitleText(
              "Popping",
              fontSize: 16.0,
            ),
            Gap(4.0),
            OrangeIcon(),
          ],
        ),
      ),
      body: Padding(
        padding: Constants.mainScreenPadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Event Name
              Align(
                alignment: Alignment.centerLeft,
                child: NormalText(
                  '${widget.eventPartialDetails.eventName} 🎉',
                  fontSize: 24.0,
                  textColor: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),

              CreateEventDateWidget(
                showAttendanceNumber: true,
                publicOrPrivate: widget.eventPartialDetails.publicOrPrivate,
                eventDateTime: widget.eventPartialDetails.eventDateTime,
                attendance: widget.eventPartialDetails.numberOfAttenddees,
              ),

              Gap(25.0.h),

              //This contains the event image.
              Container(
                height: 160.h,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey),
                child: AppVideoWidget(
                  file: widget.eventPartialDetails.eventVideo,
                  aspectRatio: 4.15 / 1.8,
                ),
              ),

              //
              Gap(25.0.h),

              //Location Text widget.
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const NormalText(
                    'Location',
                    fontSize: 10.0,
                    textColor: greyFontColor,
                  ),
                  const Gap(4.0),
                  NormalText(
                    widget.eventPartialDetails.eventAddress.address,
                    fontWeight: FontWeight.w700,
                    textColor: greyFontColor,
                  ),
                  const Gap(4.0),
                  Row(
                    children: const [
                      NormalText(
                        'Powered by',
                        fontSize: 10.0,
                        textColor: greyFontColor,
                      ),
                      Gap(2.0),
                      GoogleText(),
                    ],
                  ),
                ],
              ),

              Gap(25.0.h),

              AddMorePhotosBoxes(
                greyFontColor: greyFontColor,
                imageUrlsCallBack: (List<String> imageUrls) {
                  selectedImageUrls = imageUrls;
                },
              ),

              Gap(25.0.h),

              EventAccessSelector(
                greyFontColor: greyFontColor,
                eventAccessCallback: (value) {
                  eventAccess = value;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Builder(builder: (context) {
        if (state is CreateEventLoading) {
          return const CircularProgressIndicator();
        }
        return AppArrowButton(
          'Complete',
          width: 145.0.w,
          onPressed: completeEventCreationProcess,
        );
      }),
    );
  }
}
