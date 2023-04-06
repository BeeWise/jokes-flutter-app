import 'package:jokes/models/joke/Joke.dart';
import 'package:uuid/uuid.dart';

import '../../components/attributed_text/AttributedText.dart';
import '../../operations/base/errors/OperationError.dart';

class JokesModelsPaginationModel {
  bool isFetchingItems = false;
  bool noMoreItems = false;
  bool hasError = false;

  int currentPage = 0;
  int limit = 30;

  List<Joke> items = [];

  Map<JokesModelsTopItemType, bool> isFetchingTopItems = {};
  Map<JokesModelsTopItemType, Joke?> topItem = {};

  void reset() {
    this.isFetchingItems = false;
    this.noMoreItems = false;
    this.hasError = false;
    this.currentPage = 0;
    this.limit = 10;
    this.items = [];

    this.isFetchingTopItems = {};
    this.topItem = {};
  }
}

class JokesModelsTopItemType {
  static JokesModelsTopItemType daily = JokesModelsTopItemType(0);
  static JokesModelsTopItemType weekly = JokesModelsTopItemType(1);
  static JokesModelsTopItemType monthly = JokesModelsTopItemType(2);
  static JokesModelsTopItemType yearly = JokesModelsTopItemType(3);

  static List<JokesModelsTopItemType> allCases = [
    daily,
    weekly,
    monthly,
    yearly
  ];

  int value;

  JokesModelsTopItemType(this.value);

  static JokesModelsTopItemType? from(int? value) {
    if (value == null) {
      return null;
    }
    return JokesModelsTopItemType(value);
  }

  JokesModelsTopItemType? nextType() {
    if (this.value == JokesModelsTopItemType.daily.value) {
      return JokesModelsTopItemType.weekly;
    } else if (this.value == JokesModelsTopItemType.weekly) {
      return JokesModelsTopItemType.monthly;
    } else if (this.value == JokesModelsTopItemType.monthly) {
      return JokesModelsTopItemType.yearly;
    }
    return null;
  }
}

class JokesModelsTopItemModel {
  JokesModelsTopItemType type;
  Joke item;

  JokesModelsTopItemModel(this.type, this.item);
}

enum JokesModelsItemType {
  topJokeText,
  topJokeQna,
  jokeText,
  jokeQna,
  shareApp,
  pushNotifications,
  space,
}

class JokesModelsDisplayedItem {
  String uuid = const Uuid().v4();
  JokesModelsItemType type;
  dynamic model;

  JokesModelsDisplayedItem(this.type, this.model);
}

class JokesModelsItemsPresentationResponse {
  List<Joke> items;
  JokesModelsTopItemModel? topItemModel;

  JokesModelsItemsPresentationResponse(this.items, this.topItemModel);
}

class JokesModelsItemsPresentationViewModel {
  List<JokesModelsDisplayedItem> items;

  JokesModelsItemsPresentationViewModel(this.items);
}

class JokesModelsErrorPresentationResponse {
  OperationError error;

  JokesModelsErrorPresentationResponse(this.error);
}

class JokesModelsErrorPresentationViewModel {
  AttributedText errorText;

  JokesModelsErrorPresentationViewModel(this.errorText);
}

class JokesModelsNoMoreItemsPresentationViewModel {
  AttributedText errorText;

  JokesModelsNoMoreItemsPresentationViewModel(this.errorText);
}
