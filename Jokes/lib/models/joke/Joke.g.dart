// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Joke.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Joke _$JokeFromJson(Map<String, dynamic> json) => Joke()
  ..id = json['id'] as int?
  ..uuid = json['uuid'] as String?
  ..text = json['text'] as String?
  ..answer = json['answer'] as String?
  ..user = json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>)
  ..likeCount = json['like_count'] as int? ?? 0
  ..dislikeCount = json['dislike_count'] as int? ?? 0
  ..commentCount = json['comment_count'] as int? ?? 0
  ..createdAt = json['created_at'] as String?
  ..like = json['like'] == null
      ? null
      : Like.fromJson(json['like'] as Map<String, dynamic>)
  ..source = json['source'] as String?
  ..status = json['status'] as int? ?? 0
  ..reason = json['reason'] == null
      ? null
      : JokeReason.fromJson(json['reason'] as Map<String, dynamic>)
  ..type = json['type'] as int?;

Map<String, dynamic> _$JokeToJson(Joke instance) => <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'text': instance.text,
      'answer': instance.answer,
      'user': instance.user?.toJson(),
      'like_count': instance.likeCount,
      'dislike_count': instance.dislikeCount,
      'comment_count': instance.commentCount,
      'created_at': instance.createdAt,
      'like': instance.like?.toJson(),
      'source': instance.source,
      'status': instance.status,
      'reason': instance.reason?.toJson(),
      'type': instance.type,
    };

JokeReason _$JokeReasonFromJson(Map<String, dynamic> json) => JokeReason()
  ..id = json['id'] as int?
  ..uuid = json['uuid'] as String?
  ..type = json['type'] as int?
  ..text = json['text'] as String?
  ..createdAt = json['created_at'] as String?;

Map<String, dynamic> _$JokeReasonToJson(JokeReason instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'type': instance.type,
      'text': instance.text,
      'created_at': instance.createdAt,
    };
