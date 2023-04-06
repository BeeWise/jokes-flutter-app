import '../user/User.dart';
import '../like/Like.dart';

import 'package:json_annotation/json_annotation.dart';

part 'Joke.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Joke {
  int? id;
  String? uuid;

  String? text;
  String? answer;

  User? user;

  @JsonKey(defaultValue: 0)
  int likeCount = 0;

  @JsonKey(defaultValue: 0)
  int dislikeCount = 0;

  @JsonKey(defaultValue: 0)
  int commentCount = 0;

  String? createdAt;

  Like? like;

  String? source;

  @JsonKey(defaultValue: 0)
  int status = JokeStatus.pending.value;

  JokeReason? reason;

  int? type;

  Joke();

  factory Joke.fromJson(Map<String, dynamic> json) => _$JokeFromJson(json);

  Map<String, dynamic> toJson() => _$JokeToJson(this);

  bool isLiked() {
    if (this.like != null) {
      return this.like?.type == LikeType.like.value;
    }
    return false;
  }

  bool isDisliked() {
    if (this.like != null) {
      return this.like?.type == LikeType.dislike.value;
    }
    return false;
  }
}

class JokeStatus {
  static JokeStatus pending = JokeStatus(0);
  static JokeStatus approved = JokeStatus(1);
  static JokeStatus rejected = JokeStatus(2);
  static JokeStatus adminRemoved = JokeStatus(3);
  static JokeStatus ownerRemoved = JokeStatus(4);

  static List allCases = [
    pending,
    approved,
    rejected,
    adminRemoved,
    ownerRemoved
  ];

  int value;

  JokeStatus(this.value);

  static JokeStatus? from(int? value) {
    if (value == null) {
      return null;
    }
    return JokeStatus(value);
  }

  String? name() {
    if (this.value == pending.value) {
      return 'Pending';
    } else if (this.value == approved.value) {
      return 'Approved';
    } else if (this.value == rejected.value) {
      return 'Rejected';
    } else if (this.value == adminRemoved.value) {
      return 'Removed by admin';
    } else if (this.value == ownerRemoved.value) {
      return 'Removed';
    }
    return null;
  }
}

class JokeOrderBy {
  static JokeOrderBy points = JokeOrderBy(0);
  static JokeOrderBy latest = JokeOrderBy(1);

  static List allCases = [points, latest];

  int value;

  JokeOrderBy(this.value);

  static JokeOrderBy? from(int? value) {
    if (value == null) {
      return null;
    }
    return JokeOrderBy(value);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class JokeReason {
  int? id;
  String? uuid;

  int? type;
  String? text;

  String? createdAt;

  JokeReason();

  factory JokeReason.fromJson(Map<String, dynamic> json) =>
      _$JokeReasonFromJson(json);

  Map<String, dynamic> toJson() => _$JokeReasonToJson(this);
}

class JokeReasonType {
  static JokeReasonType custom = JokeReasonType(0);
  static JokeReasonType spam = JokeReasonType(1);
  static JokeReasonType vulgar = JokeReasonType(2);

  static List allCases = [custom, spam, vulgar];

  int value;

  JokeReasonType(this.value);

  static JokeReasonType? from(int? value) {
    if (value == null) {
      return null;
    }
    return JokeReasonType(value);
  }
}

class JokeReport {
  int? id;
  String? uuid;

  int? type;
  String? text;

  String? createdAt;

  JokeReport();
}

class JokeReportType {
  static JokeReportType custom = JokeReportType(0);
  static JokeReportType sexuality = JokeReportType(1);
  static JokeReportType violence = JokeReportType(2);
  static JokeReportType copyright = JokeReportType(3);
  static JokeReportType illegal = JokeReportType(4);

  static List allCases = [custom, sexuality, violence, copyright, illegal];

  int value;

  JokeReportType(this.value);

  static JokeReportType? from(int? value) {
    if (value == null) {
      return null;
    }
    return JokeReportType(value);
  }
}

class JokeType {
  static JokeType text = JokeType(0);
  static JokeType qna = JokeType(1);

  static List allCases = [text, qna];

  int value;

  JokeType(this.value);

  static JokeType? from(int? value) {
    if (value == null) {
      return null;
    }
    return JokeType(value);
  }
}
