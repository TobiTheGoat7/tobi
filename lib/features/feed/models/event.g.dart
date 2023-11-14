// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventFeedData _$EventFeedDataFromJson(Map<String, dynamic> json) =>
    EventFeedData(
      id: json['id'] as num?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      videoUrl: json['video_url'] as String?,
      peopleAttending: json['people_attending'] as num?,
      peopleJoined: json['people_joined'] as num?,
      peopleLeft: json['people_left'] as num?,
      location: json['location'] as String?,
      eventCreator: json['user'] == null
          ? null
          : EventCreator.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventFeedDataToJson(EventFeedData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'video_url': instance.videoUrl,
      'user': instance.eventCreator,
      'people_attending': instance.peopleAttending,
      'people_joined': instance.peopleJoined,
      'people_left': instance.peopleLeft,
      'location': instance.location,
    };
