import 'package:outt/features/create_event/models/event_access.dart';
import 'package:outt/features/create_event/models/event_details_dto.dart';

class EventFullDetailsDTO {
  final EventPartialDetailsDTO eventPartialDetailsDTO;
  final List<String> imageUrls;
  final EventAccess eventAccess;

  EventFullDetailsDTO({
    required this.eventPartialDetailsDTO,
    required this.imageUrls,
    required this.eventAccess,
  });
}
