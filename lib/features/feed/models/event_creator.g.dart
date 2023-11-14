// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_creator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventCreator _$EventCreatorFromJson(Map<String, dynamic> json) => EventCreator(
      id: json['id'] as num?,
      name: json['name'] as String?,
      profilePicture: json['profile_picture'] as String?,
    );

Map<String, dynamic> _$EventCreatorToJson(EventCreator instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profile_picture': instance.profilePicture,
    };
