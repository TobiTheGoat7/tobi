import 'package:flutter/material.dart';
import 'package:outt/features/common/text_widgets.dart';

class OutlineNumberRadioWidget extends StatefulWidget {
  final String text;
  final String? groupValue;
  final void Function(String?)? onSelectItem;
  const OutlineNumberRadioWidget(
    this.text, {
    super.key,
    this.groupValue,
    this.onSelectItem,
  });

  @override
  State<OutlineNumberRadioWidget> createState() =>
      _OutlineNumberRadioWidgetState();
}

class _OutlineNumberRadioWidgetState extends State<OutlineNumberRadioWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    if (widget.groupValue != null) {
      isSelected = widget.groupValue == widget.text;
    }
    return GestureDetector(
      onTap: () {
        if (widget.onSelectItem != null) {
          widget.onSelectItem!(widget.text);
        }
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
