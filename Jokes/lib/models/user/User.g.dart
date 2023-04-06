// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..id = json['id'] as int?
  ..uuid = json['uuid'] as String?
  ..username = json['username'] as String?
  ..email = json['email'] as String?
  ..name = json['name'] as String?
  ..createdAt = json['created_at'] as String?
  ..photo = json['photo'] == null
      ? null
      : Photo.fromJson(json['photo'] as Map<String, dynamic>)
  ..points = json['points'] as String?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'username': instance.username,
      'email': instance.email,
      'name': instance.name,
      'created_at': instance.createdAt,
      'photo': instance.photo?.toJson(),
      'points': instance.points,
    };
