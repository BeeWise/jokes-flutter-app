// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo()
  ..id = json['id'] as int?
  ..uuid = json['uuid'] as String?
  ..url = json['url'] as String?
  ..url150 = json['url_150'] as String?
  ..url450 = json['url_450'] as String?
  ..createdAt = json['created_at'] as String?;

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'url': instance.url,
      'url_150': instance.url150,
      'url_450': instance.url450,
      'created_at': instance.createdAt,
    };
