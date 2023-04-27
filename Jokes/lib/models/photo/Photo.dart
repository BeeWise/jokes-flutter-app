import 'package:json_annotation/json_annotation.dart';

part 'Photo.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Photo {
  int? id;
  String? uuid;

  String? url;

  @JsonKey(name: 'url_150')
  String? url150;

  @JsonKey(name: 'url_450')
  String? url450;

  String? createdAt;

  Photo();

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
