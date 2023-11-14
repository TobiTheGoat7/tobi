///So when the create event bottom sheet is opening
/// the Create event screen.
/// this model is the class that's used to build
/// the create event screen.
class CreateEventBottomSheetItem {
  final String eventName;
  final String publicOrPrivate;
  final DateTime eventDateTime;

  CreateEventBottomSheetItem({
    required this.eventName,
    required this.publicOrPrivate,
    required this.eventDateTime,
  });

  CreateEventBottomSheetItem copyWith(
    String? eventName,
    String? publicOrPrivate,
    DateTime? eventDateTime,
  ) {
    return CreateEventBottomSheetItem(
      eventName: eventName ?? this.eventName,
      publicOrPrivate: publicOrPrivate ?? this.publicOrPrivate,
      eventDateTime: eventDateTime ?? this.eventDateTime,
    );
  }
}
