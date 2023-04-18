import 'package:jokes/models/joke/Joke.dart';
import 'package:uuid/uuid.dart';

import '../../components/attributed_text/AttributedText.dart';
import '../../operations/base/errors/OperationError.dart';

class PaginationModel {
  bool isFetchingItems = false;
  bool noMoreItems = false;
  bool hasError = false;

  int currentPage = 0;
  int limit = 30;

  List<Joke> items = [];
  List<Joke> readJokes = [];

  void reset() {
    this.isFetchingItems = false;
    this.noMoreItems = false;
    this.hasError = false;
    this.currentPage = 0;
    this.limit = 10;
    this.items = [];

    this.readJokes = [];
  }
}

enum ItemType {
  jokeText,
  jokeQna,
  space,
}

class DisplayedItem {
  String uuid = const Uuid().v4();
  ItemType type;
  dynamic model;

  DisplayedItem(this.type, this.model);
}

class ItemsPresentationResponse {
  List<Joke> items;
  List<Joke> readJokes;

  ItemsPresentationResponse(this.items, this.readJokes);
}

class ItemsPresentationViewModel {
  List<DisplayedItem> items;

  ItemsPresentationViewModel(this.items);
}

class ErrorPresentationResponse {
  OperationError error;

  ErrorPresentationResponse(this.error);
}

class ErrorPresentationViewModel {
  AttributedText errorText;

  ErrorPresentationViewModel(this.errorText);
}

class NoMoreItemsPresentationViewModel {
  AttributedText errorText;

  NoMoreItemsPresentationViewModel(this.errorText);
}

class ActionAlertPresentationResponse {
  OperationError error;

  ActionAlertPresentationResponse(this.error);
}

class ActionAlertPresentationViewModel {
  String? title;
  String? message;

  ActionAlertPresentationViewModel(this.title, this.message);
}

class ItemSelectionRequest {
  String? id;

  ItemSelectionRequest(this.id);
}

class ItemReadStateResponse {
  bool isRead;
  String? id;

  ItemReadStateResponse(this.isRead, this.id);
}

class ItemReadStateViewModel {
  bool isRead;
  String? id;

  ItemReadStateViewModel(this.isRead, this.id);
}

class ItemScrollResponse {
  bool animated;
  int index;

  ItemScrollResponse(this.animated, this.index);
}

class ItemScrollViewModel {
  Duration duration;
  int index;

  ItemScrollViewModel(this.duration, this.index);
}