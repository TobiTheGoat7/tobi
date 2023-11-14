import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:outt/constants/colors.dart';
import 'package:outt/features/common/icons/orange_icon.dart';
import 'package:outt/features/common/text_widgets.dart';
import 'package:outt/features/create_event/app/widgets/price_entry_text_field.dart';
import 'package:outt/features/create_event/models/event_access.dart';

class EventAccessSelector extends StatefulWidget {
  final void Function(EventAccess)? eventAccessCallback;
  const EventAccessSelector({
    super.key,
    required this.greyFontColor,
    this.eventAccessCallback,
  });

  final Color greyFontColor;

  @override
  State<EventAccessSelector> createState() => _EventAccessSelectorState();
}

class _EventAccessSelectorState extends State<EventAccessSelector> {
  int checkBoxIndex = 100;
  TextEditingController priceCtrl = TextEditingController(text: '0');
  bool isPriceFieldVisible = false;

  String getSelectedEventAccess(int index) {
    if (index == 0) {
      return '3';
    } else if (index == 1) {
      return '4';
    } else if (index == 2) {
      return '5';
    } else {
      return '0';
    }
  }

  @override
  void dispose() {
    priceCtrl.dispose();
    super.dispose();
  }

  returnEventAccessData() {
    if (widget.eventAccessCallback != null) {
      final accessId = getSelectedEventAccess(checkBoxIndex);

      final price =
          accessId == '3' ? 0.0 : double.tryParse(priceCtrl.text) ?? 0;
      final eventAccess = EventAccess(accessId, price);
      widget.eventAccessCallback!(eventAccess);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NormalText(
              'Event Access?',
              textColor: widget.greyFontColor,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
            Icon(
              Icons.expand_more,
              color: widget.greyFontColor,
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 500,
            child: ListView.builder(
              itemCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      checkBoxIndex = i;
                    });
                    returnEventAccessData();
                  },
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                                setState(() {
                                  checkBoxIndex = i;
                                });
                                returnEventAccessData();
                              },
                            ),
                            SizedBox(
                              width: 110.0.w,
                              child: Row(
                                children: [
                                  Text(
                                    i == 0
                                        ? 'Free'
                                        : i == 1
                                            ? 'Event Ticket'
                                            : 'Budget for each',
                                    style: const TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const Gap(1.0),
                                  i == 2
                                      ? const OrangeIcon()
                                      : i == 1
                                          ? const Icon(
                                              Icons.local_offer_outlined,
                                              size: 18,
                                            )
                                          : const SizedBox.shrink()
                                ],
                              ),
                            ),
                            Text(
                              i == 0
                                  ? 'Free access'
                                  : i == 1
                                      ? 'Paid access for each person to come in'
                                      : 'Meet Budget',
                              style: const TextStyle(
                                fontSize: 9.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF938E8E),
                              ),
                            )
                          ],
                        ),
                        //Price Field

                        if (i != 0 && checkBoxIndex == i)
                          Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: PriceEntryTextField(
                              textEditingController: priceCtrl,
                              onChanged: (value) {
                                returnEventAccessData();
                              },
                            ),
                          ).animate(effects: [
                            const FadeEffect(
                              duration: Duration(milliseconds: 300),
                            ),
                            const SlideEffect(
                              duration: Duration(milliseconds: 300),
                            )
                          ]),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
