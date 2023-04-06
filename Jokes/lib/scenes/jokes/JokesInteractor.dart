import 'package:jokes/operations/base/errors/OperationError.dart';
import 'package:jokes/scenes/jokes/JokesModels.dart';
import 'package:jokes/scenes/jokes/JokesPresenter.dart';
import 'package:jokes/scenes/jokes/JokesWorker.dart';

import '../../models/joke/Joke.dart';

abstract class JokesBusinessLogic {
  void shouldFetchJokes();
}

class JokesInteractor extends JokesBusinessLogic
    implements JokesWorkerDelegate {
  JokesWorker? worker;
  JokesPresentationLogic? presenter;

  JokesModelsPaginationModel paginationModel = JokesModelsPaginationModel();

  bool isSigningIn = false;

  JokesInteractor() {
    this.worker = JokesWorker(this);
  }

  @override
  void shouldFetchJokes() {
    if (!this.paginationModel.isFetchingItems &&
        !this.paginationModel.noMoreItems) {
      this.paginationModel.isFetchingItems = true;
      this.presenter?.presentLoadingState();
      this.worker?.fetchJokes(this.paginationModel.currentPage,
          this.paginationModel.limit, JokeOrderBy.latest.value);
    }
  }

  @override
  void successDidFetchJokes(List<Joke> jokes) {
    this.paginationModel.isFetchingItems = false;
    this.paginationModel.items.addAll(jokes);
    this.paginationModel.currentPage += 1;
    this.paginationModel.hasError = false;

    this.presenter?.presentNotLoadingState();
    this.presentItems();
    this.presenter?.presentRemoveError();

    this.shouldVerifyNoMoreItems(jokes.length);
  }

  @override
  void failureDidFetchJokes(OperationError error) {
    this.paginationModel.isFetchingItems = false;
    this.paginationModel.hasError = true;
    this.presenter?.presentNotLoadingState();
    this.presenter?.presentError(JokesModelsErrorPresentationResponse(error));
  }

  presentItems() {
    this.presenter?.presentItems(JokesModelsItemsPresentationResponse(
        this.itemsToPresent(), this.topItemToPresent()));
  }

  List<Joke> itemsToPresent() {
    List<JokesModelsTopItemType> types = JokesModelsTopItemType.allCases;
    Joke? topItem;
    for (var index = 0; index < types.length; index++) {
      JokesModelsTopItemType type = types[index];
      Joke? item = this.paginationModel.topItem[type];
      if (this.paginationModel.topItem.containsKey(type) && item != null) {
        topItem = item;
      }
    }
    if (topItem != null) {
      return this
          .paginationModel
          .items
          .where((element) => element.uuid != topItem?.uuid)
          .toList();
    }
    return this.paginationModel.items;
  }

  JokesModelsTopItemModel? topItemToPresent() {
    List<JokesModelsTopItemType> types = JokesModelsTopItemType.allCases;
    for (var index = 0; index < types.length; index++) {
      JokesModelsTopItemType type = types[index];
      Joke? item = this.paginationModel.topItem[type];
      if (this.paginationModel.topItem.containsKey(type) && item != null) {
        return JokesModelsTopItemModel(type, item);
      }
    }
    return null;
  }

  shouldVerifyNoMoreItems(int count) {
    if (count < this.paginationModel.limit) {
      this.paginationModel.noMoreItems = true;
      this.presenter?.presentNoMoreItems();
    }
  }
}
