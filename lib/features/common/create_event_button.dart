import 'package:flutter/material.dart';
import 'package:outt/features/create_event/app/create_event_bottom_sheet.dart';

class CreateEventButton extends StatelessWidget {
  final double? size;
  const CreateEventButton({
    super.key,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size ?? 30.0,
        width: size ?? 30.0,
        child: OutlinedButton(
          onPressed: () {
            showCreateEventBottomSheet(context);
          },
          child: const Icon(
            Icons.add,
            size: 25,
          ),
        ),
      ),
    );
  }
}
