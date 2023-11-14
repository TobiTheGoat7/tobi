import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:outt/configs/navigator.dart';
import 'package:outt/features/common/app_snackbar.dart';
import 'package:outt/features/common/button_widget.dart';
import 'package:outt/features/common/icons/bottom_sheet_grey_bar.dart';
import 'package:outt/features/common/icons/orange_icon.dart';
import 'package:outt/features/common/text_widgets.dart';
import 'package:outt/features/create_event/app/create_event_page.dart';
import 'package:outt/features/create_event/app/date_formater.dart';
import 'package:outt/features/create_event/app/widgets/create_event_outline_box.dart';
import 'package:outt/features/create_event/models/create_event_bottom_sheet_item.dart';

Future<void> showCreateEventBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      ),
    ),
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SizedBox(
          height: 450.0.h,
          child: StatefulBuilder(
            builder: (context, setstate) {
              return const _ModalBottomContents();
            },
          ),
        ),
      );
    },
  );
}

class _ModalBottomContents extends StatefulWidget {
  const _ModalBottomContents({Key? key}) : super(key: key);
  @override
  State<_ModalBottomContents> createState() => _ModalBottomContentsState();
}

class _ModalBottomContentsState extends State<_ModalBottomContents> {
  //the value from checkbox when private or public is selected.
  int checkBoxIndex = 2;
  late final TextEditingController eventNameController;
  late final TextEditingController eventDateController;
  late final TextEditingController eventTimeController;
  String? publicOrPrivate;
  String? amOrpm = 'PM';

  @override
  void initState() {
    super.initState();
    eventNameController = TextEditingController();
    eventDateController = TextEditingController();
    eventTimeController = TextEditingController();
  }

  @override
  void dispose() {
    eventNameController.dispose();
    eventTimeController.dispose();
    eventDateController.dispose();
    super.dispose();
  }

  _updatePrivateOrPublic(int i) {
    publicOrPrivate = i == 0 ? "Private" : "Public";
    setState(() {
      checkBoxIndex = i;
    });
  }

  _navigateToCreateEventScreen(BuildContext context) {
    String message = "";
    if (eventNameController.text.isEmpty) {
      message = "Event Name is Empty";
    } else if (publicOrPrivate == null) {
      message = "Please Select if Private or Public";
    } else if (eventDateController.text.isEmpty) {
      message = "Event Date is Empty";
    } else if (eventTimeController.text.isEmpty) {
      message = "Event Time is Empty";
    } else {
      String dateString = eventDateController.text;
      String timeString = eventTimeController.text;
      //Not in UTC yet. but local timezone.
      final dateTime = DateFormat('dd-MM-yyyy HH:mm a')
          .parse('$dateString $timeString $amOrpm');
      CreateEventBottomSheetItem create = CreateEventBottomSheetItem(
          eventName: eventNameController.text,
          publicOrPrivate: publicOrPrivate ?? "",
          eventDateTime: dateTime);
      Navigator.pop(context);
      navigateName(context, CreateEventScreen.route, args: create);
    }
    if (message.isNotEmpty) {
      AppSnackbar(context, isError: true).showToast(text: message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0.w),
      child: Column(
        children: [
          //Black Bar
          const BottomSheetGreyBar(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const NormalText(
                'Whats Popping',
                textColor: Colors.black,
              ),
              Gap(10.0.w),
              const OrangeIcon(),
            ],
          ),
          Gap(40.0.h),
          //
          CreateEventOutlineBox(
            title: 'Event Name',
            child: TextFormField(
              controller: eventNameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration.collapsed(
                  hintText: 'The Title of your event'),
            ),
          ),
          const Gap(4.0),
          Row(
            children: const [
              NormalText(
                "Like Tayo's Birthday 🎉,  Friday night at Derik's Beach 🌙",
                fontSize: 10,
                fontWeight: FontWeight.w400,
                textColor: Color(0xFF938E8E),
              ),
            ],
          ),
          Gap(10.0.h),

          // Private or Public
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 200,
              height: 20,
              child: ListView.builder(
                itemCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      _updatePrivateOrPublic(i);
                    },
                    child: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Checkbox(
                            value: checkBoxIndex == i,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            activeColor: Colors.black,
                            onChanged: (value) {
                              _updatePrivateOrPublic(i);
                            },
                          ),
                          Text(i == 0 ? 'Private' : 'Public'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          //Space for Check Boxes

          Gap(30.0.h),
          //Date things.
          Row(
            children: [
              SizedBox(
                width: size.width * 0.42,
                child: CreateEventOutlineBox(
                  title: 'Date',
                  subtitle: 'dd-mm-yyyy',
                  child: TextFormField(
                    controller: eventDateController,
                    keyboardType: TextInputType.datetime,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9-]")),
                      LengthLimitingTextInputFormatter(10),
                      DateFormatter()
                    ],
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Enter Event Date'),
                  ),
                ),
              ),
              const Gap(5.0),
              CreateEventOutlineBox(
                title: 'Time',
                subtitle: 'hr/mins',
                child: FittedBox(
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.25,
                        child: TextFormField(
                          controller: eventTimeController,
                          keyboardType: TextInputType.datetime,
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            _navigateToCreateEventScreen(context);
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9:]")),
                            LengthLimitingTextInputFormatter(5),
                            TimeInputFormatter()
                          ],
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Enter Time'),
                        ),
                      ),
                      Container(
                        width: 52.0,
                        height: 22.0,
                        padding: const EdgeInsets.only(
                          left: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.4, color: Colors.black),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            icon: const Icon(Icons.expand_more),
                            iconSize: 22,
                            value: amOrpm,
                            borderRadius: BorderRadius.circular(10.0),
                            items: ['AM', 'PM']
                                .map((e) => DropdownMenuItem(
                                    value: e, child: NormalText(e)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                amOrpm = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Gap(50.0),

          AppArrowButton(
            'Create',
            onPressed: () {
              _navigateToCreateEventScreen(context);
            },
          )
        ],
      ),
    );
  }
}
