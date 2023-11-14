import 'dart:io';

import 'package:outt/features/create_event/models/event_address.dart';

class EventPartialDetailsDTO {
  final String eventName;
  final String publicOrPrivate;
  final DateTime eventDateTime;
  final File eventVideo;
  final String eventUploadedVideoUrl;
  final String numberOfAttenddees;
  final EventAddress eventAddress;

  EventPartialDetailsDTO({
    required this.eventName,
    required this.publicOrPrivate,
    required this.eventDateTime,
    required this.eventVideo,
    required this.eventUploadedVideoUrl,
    required this.numberOfAttenddees,
    required this.eventAddress,
  });
}
