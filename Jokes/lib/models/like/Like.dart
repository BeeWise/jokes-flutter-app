import '../user/User.dart';
import '../joke/Joke.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Like.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Like {
  int? id;
  String? uuid;

  int? type;

  Joke? joke;
  User? user;

  String? createdAt;

  Like();

  factory Like.fromJson(Map<String, dynamic> json) => _$LikeFromJson(json);

  Map<String, dynamic> toJson() => _$LikeToJson(this);
}

class LikeType {
  static LikeType like = LikeType(0);
  static LikeType dislike = LikeType(1);

  static List allCases = [like, dislike];

  int value;

  LikeType(this.value);

  static LikeType? from(int? value) {
    if (value == null) {
      return null;
    }
    return LikeType(value);
  }
}
