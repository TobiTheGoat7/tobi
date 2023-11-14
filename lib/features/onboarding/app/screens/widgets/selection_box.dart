import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outt/features/common/text_widgets.dart';

class SelectionBox extends StatefulWidget {
  final String text;
  const SelectionBox(this.text, {super.key});

  @override
  State<SelectionBox> createState() => _SelectionBoxState();
}

class _SelectionBoxState extends State<SelectionBox> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      borderRadius: BorderRadius.circular(30.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 44.0.h,
        padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 12.0.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: isSelected ? Colors.black : Colors.transparent,
          border: Border.all(
            color: const Color(0xFFD9D9D9),
          ),
        ),
        child: NormalText(
          widget.text,
          textColor: isSelected ? Colors.white : const Color(0xFF596273),
          fontSize: 12.0,
          fontWeight: FontWeight.w700,
          fontFamily: 'Mulish',
        ),
      ),
    );
  }
}
