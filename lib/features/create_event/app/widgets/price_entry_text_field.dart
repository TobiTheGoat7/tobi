import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outt/constants/colors.dart';
import 'package:outt/features/common/text_widgets.dart';

class PriceEntryTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final Function(String)? onChanged;
  const PriceEntryTextField({
    super.key,
    this.textEditingController,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const inputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 0.5,
        color: AppColors.createEventBorder,
      ),
    );
    return SizedBox(
      height: 30.0.h,
      width: 170.0.w,
      child: TextFormField(
        controller: textEditingController,
        textAlign: TextAlign.end,
        style:
            const TextStyle(fontSize: 12.0, color: AppColors.createEventBorder),
        keyboardType: const TextInputType.numberWithOptions(),
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(right: 10.0),
          prefixIcon: Container(
            width: 10,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: AppColors.createEventBorder,
                  width: 0.5,
                ),
              ),
            ),
            child: const Center(
              child: NormalText(
                'NGN',
                fontSize: 8.0,
                fontWeight: FontWeight.w700,
                textColor: AppColors.createEventBorder,
              ),
            ),
          ),
          border: inputBorder,
          focusedBorder: inputBorder,
          errorBorder: inputBorder,
        ),
        //TODO: price input formatters.
        inputFormatters: [],
      ),
    );
  }
}
