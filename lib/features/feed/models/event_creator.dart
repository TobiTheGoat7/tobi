import 'package:json_annotation/json_annotation.dart';

part 'event_creator.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EventCreator {
  final num? id;
  final String? name;
  final String? profilePicture;

  EventCreator({
    this.id,
    this.name,
    this.profilePicture,
  });

  factory EventCreator.fromJson(Map<String, dynamic> json) =>
      _$EventCreatorFromJson(json);

  Map<String, dynamic> toJson() => _$EventCreatorToJson(this);
}
