import '../photo/Photo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class User {
  int? id;
  String? uuid;

  String? username;
  String? email;
  String? name;

  String? createdAt;

  Photo? photo;

  String? points;

  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
