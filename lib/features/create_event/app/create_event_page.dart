import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/configs/navigator.dart';
import 'package:outt/constants/constants.dart';
import 'package:outt/features/common/app_snackbar.dart';
import 'package:outt/features/common/button_widget.dart';
import 'package:outt/features/common/icons/orange_icon.dart';
import 'package:outt/features/common/text_widgets.dart';
import 'package:outt/features/create_event/app/complete_create_event_page.dart';
import 'package:outt/features/create_event/app/widgets/create_event_date_widget.dart';
import 'package:outt/features/create_event/app/widgets/create_video_upload_box.dart';
import 'package:outt/features/create_event/app/widgets/map_location_and_textfield.dart';
import 'package:outt/features/create_event/app/widgets/outline_number_radio_button.dart';
import 'package:outt/features/create_event/models/create_event_bottom_sheet_item.dart';
import 'package:outt/features/create_event/models/event_address.dart';
import 'package:outt/features/create_event/models/event_details_dto.dart';
import 'package:outt/routes.dart';

class CreateEventScreen extends StatefulWidget {
  static final route = ScreenPaths.createEventScreen;

  final CreateEventBottomSheetItem createEventBottomSheetItem;
  const CreateEventScreen({
    super.key,
    required this.createEventBottomSheetItem,
  });

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final mapExpandedNotifier = ValueNotifier<bool>(false);
  final eventAddressNotifier = ValueNotifier<EventAddress?>(null);
  String? mediaUrl;
  File? eventVideoFile;
  String numberOfPersonsAttending = '0';

  void _updatePersonsAttending(String? value) {
    if (value != null) {
      setState(() {
        numberOfPersonsAttending = value;
      });
    }
  }

  EventPartialDetailsDTO? buildEventPartialDetailsObject() {
    if (mediaUrl == null) {
      AppSnackbar(context, isError: true)
          .showToast(text: 'Please Upload Media File');
    } else if (numberOfPersonsAttending == '0') {
      AppSnackbar(context, isError: true)
          .showToast(text: 'Please Select number of Attendees');
    } else if (eventAddressNotifier.value == null) {
      AppSnackbar(context, isError: true)
          .showToast(text: 'Please Select Event Address');
    } else if (eventVideoFile == null) {
      AppSnackbar(context, isError: true)
          .showToast(text: 'Please Give Us An Event Video');
    } else {
      return EventPartialDetailsDTO(
          eventName: widget.createEventBottomSheetItem.eventName,
          publicOrPrivate: widget.createEventBottomSheetItem.publicOrPrivate,
          eventDateTime: widget.createEventBottomSheetItem.eventDateTime,
          eventVideo: eventVideoFile!,
          eventUploadedVideoUrl: mediaUrl!,
          numberOfAttenddees: numberOfPersonsAttending,
          eventAddress: eventAddressNotifier.value!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: mapExpandedNotifier,
        builder: (context, value, child) {
          bool mapExpanded = mapExpandedNotifier.value;
          return GestureDetector(
            onTap: () {
              mapExpandedNotifier.value = false;
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                leadingWidth: Constants.appLeadingWidth,
                title: Row(
                  children: const [
                    TitleText(
                      "What's Popping",
                      fontSize: 16.0,
                    ),
                    Gap(4.0),
                    OrangeIcon()
                  ],
                ),
              ),
              body: SingleChildScrollView(
                physics: mapExpandedNotifier.value
                    ? const NeverScrollableScrollPhysics()
                    : null,
                child: Stack(
                  children: [
                    AnimatedOpacity(
                      duration: Constants.animationDuration,
                      opacity: mapExpanded ? 0 : 1,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Padding(
                          padding: Constants.mainScreenPadding,
                          child: Column(
                            children: [
                              //Event Name
                              Align(
                                alignment: Alignment.centerLeft,
                                child: NormalText(
                                  "${widget.createEventBottomSheetItem.eventName} 🎉",
                                  fontSize: 24.0,
                                  textColor: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              //Event Date
                              CreateEventDateWidget(
                                eventDateTime: widget
                                    .createEventBottomSheetItem.eventDateTime,
                                publicOrPrivate: widget
                                    .createEventBottomSheetItem.publicOrPrivate,
                              ),

                              Gap(20.0.h),

                              CreateVideoUploadBox(
                                onUploadSuccess: (uploadFileUrl, file) {
                                  mediaUrl = uploadFileUrl;
                                  eventVideoFile = file;
                                },
                              ),

                              Gap(30.0.h),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: NormalText(
                                  'How many persons are attending?',
                                  fontSize: 10.0,
                                  textColor: Color(0xFF444242),
                                ),
                              ),
                              Gap(10.0.h),

                              Row(
                                children: [
                                  OutlineNumberRadioWidget(
                                    '2',
                                    groupValue: numberOfPersonsAttending,
                                    onSelectItem: _updatePersonsAttending,
                                  ),
                                  Gap(10.0.h),
                                  OutlineNumberRadioWidget(
                                    '4',
                                    groupValue: numberOfPersonsAttending,
                                    onSelectItem: _updatePersonsAttending,
                                  ),
                                  Gap(10.0.h),
                                  OutlineNumberRadioWidget(
                                    '6',
                                    groupValue: numberOfPersonsAttending,
                                    onSelectItem: _updatePersonsAttending,
                                  ),
                                  Gap(10.0.h),
                                  OutlineNumberRadioWidget(
                                    '12',
                                    groupValue: numberOfPersonsAttending,
                                    onSelectItem: _updatePersonsAttending,
                                  ),
                                  Gap(10.0.h),
                                  OutlineNumberRadioWidget(
                                    '24',
                                    groupValue: numberOfPersonsAttending,
                                    onSelectItem: _updatePersonsAttending,
                                  ),
                                  Gap(10.0.h),
                                  OutlineNumberRadioWidget(
                                    'A lot',
                                    groupValue: numberOfPersonsAttending,
                                    onSelectItem: _updatePersonsAttending,
                                  )
                                ],
                              ),

                              const Spacer(),

                              AppArrowButton(
                                'Complete',
                                width: 145.0.w,
                                onPressed: () {
                                  final eventDetailObject =
                                      buildEventPartialDetailsObject();
                                  if (eventDetailObject != null) {
                                    navigateName(
                                      context,
                                      CompleteCreateEventScreen.route,
                                      args: eventDetailObject,
                                    );
                                  }
                                },
                              ),
                              Gap(40.0.h),
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Constants.animationDuration,
                      bottom: mapExpanded ? 0 : 100.0.h,
                      child: Padding(
                        padding: Constants.mainScreenPadding,
                        child: MapLocationAndTextField(
                          mapExpandedNotifier: mapExpandedNotifier,
                          eventAddressNotifier: eventAddressNotifier,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
