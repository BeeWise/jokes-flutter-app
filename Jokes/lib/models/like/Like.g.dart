// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Like _$LikeFromJson(Map<String, dynamic> json) => Like()
  ..id = json['id'] as int?
  ..uuid = json['uuid'] as String?
  ..type = json['type'] as int?
  ..joke = json['joke'] == null
      ? null
      : Joke.fromJson(json['joke'] as Map<String, dynamic>)
  ..user = json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>)
  ..createdAt = json['created_at'] as String?;

Map<String, dynamic> _$LikeToJson(Like instance) => <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'type': instance.type,
      'joke': instance.joke?.toJson(),
      'user': instance.user?.toJson(),
      'created_at': instance.createdAt,
    };
