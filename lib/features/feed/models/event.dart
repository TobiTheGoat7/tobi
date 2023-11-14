import 'package:json_annotation/json_annotation.dart';
import 'package:outt/features/feed/models/event_creator.dart';

part 'event.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EventFeedData {
  final num? id;
  final String? name;
  final String? type;
  final String? videoUrl;
  @JsonKey(name: 'user')
  final EventCreator? eventCreator;
  final num? peopleAttending;
  final num? peopleJoined;
  final num? peopleLeft;
  final String? location;

  EventFeedData({
    this.id,
    this.name,
    this.type,
    this.videoUrl,
    this.peopleAttending,
    this.peopleJoined,
    this.peopleLeft,
    this.location,
    this.eventCreator,
  });

  factory EventFeedData.fromJson(Map<String, dynamic> json) =>
      _$EventFeedDataFromJson(json);

  Map<String, dynamic> toJson() => _$EventFeedDataToJson(this);
}
