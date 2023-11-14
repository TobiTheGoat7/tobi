import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:outt/features/common/icons/account_icon.dart';
import 'package:outt/features/common/text_widgets.dart';

class CreateEventDateWidget extends StatelessWidget {
  final bool showAttendanceNumber;
  final String? attendance;
  final DateTime eventDateTime;
  final String? publicOrPrivate;
  const CreateEventDateWidget({
    super.key,
    this.showAttendanceNumber = false,
    this.publicOrPrivate,
    required this.eventDateTime,
    this.attendance,
  });

  @override
  Widget build(BuildContext context) {
    final dateString = DateFormat('dd-MM-yyyy').format(eventDateTime);
    final timeString = DateFormat('hh:mm a').format(eventDateTime);
    return Row(
      children: [
        //
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NormalText(
              dateString,
              fontSize: 12.0,
              textColor: const Color(0xFF938E8E),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const AccountIcon(
                  size: 15,
                  color: Color(0xFF938E8E),
                ),
                const Gap(4.0),
                NormalText(
                  publicOrPrivate ?? "",
                  fontSize: 10.0,
                  textColor: const Color(0xFF938E8E),
                )
              ],
            )
          ],
        ),

        if (showAttendanceNumber)
          Row(
            children: [
              Gap(25.0.w),
              if (attendance != null) OutlineNumberWidget(attendance ?? ''),
              const Gap(4.0),
              const NormalText(
                'Attendance',
                fontSize: 10.0,
                textColor: Color(0xFF444242),
                fontWeight: FontWeight.w400,
              ),
            ],
          ),

        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NormalText(
              DateFormat('EEE, MMMM').format(eventDateTime),
              fontSize: 8.0,
              textColor: Colors.black,
            ),
            const Gap(4.0),
            OutlineNumberWidget(eventDateTime.day.toString()),
            const Gap(4.0),
            NormalText(
              timeString,
              fontSize: 8.0,
              textColor: Colors.black,
            )
          ],
        )
      ],
    );
  }
}

class OutlineNumberWidget extends StatefulWidget {
  final String text;
  const OutlineNumberWidget(
    this.text, {
    super.key,
  });

  @override
  State<OutlineNumberWidget> createState() => _OutlineNumberWidgetState();
}

class _OutlineNumberWidgetState extends State<OutlineNumberWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: NormalText(
          widget.text,
          fontSize: 16.0,
          textColor: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
