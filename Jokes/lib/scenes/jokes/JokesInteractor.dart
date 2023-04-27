import 'package:collection/collection.dart';
import 'package:jokes/operations/base/errors/OperationError.dart';
import 'package:jokes/scenes/jokes/JokesModels.dart' as JokesModels;
import 'package:jokes/scenes/jokes/JokesPresenter.dart';
import 'package:jokes/scenes/jokes/JokesWorker.dart';

import '../../models/joke/Joke.dart';

abstract class JokesBusinessLogic {
  void shouldFetchJokes();

  void shouldRefreshDetails();

  void shouldSelectReadAnswer(JokesModels.ItemSelectionRequest request);

  void shouldSelectLogo();
}

class JokesInteractor extends JokesBusinessLogic implements JokesWorkerDelegate {
  JokesWorker? worker;
  JokesPresentationLogic? presenter;

  JokesModels.PaginationModel paginationModel = JokesModels.PaginationModel();

  JokesInteractor() {
    this.worker = JokesWorker(this);
  }

  @override
  void shouldFetchJokes() {
    if (!this.paginationModel.isFetchingItems && !this.paginationModel.noMoreItems) {
      this.paginationModel.isFetchingItems = true;
      this.presenter?.presentLoadingState();
      this.worker?.fetchJokes(this.paginationModel.currentPage, this.paginationModel.limit, JokeOrderBy.latest.value);
    }
  }

  @override
  void successDidFetchJokes(List<Joke> jokes) {
    this.paginationModel.isFetchingItems = false;
    for (var element in jokes) { this.paginationModel.items.add(element); }
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
    this.presenter?.presentError(JokesModels.ErrorPresentationResponse(error));
  }

  @override
  void shouldRefreshDetails() {
    this.paginationModel.reset();

    this.presentItems();
    this.presenter?.presentRemoveError();
    this.presenter?.presentRemoveNoMoreItems();

    this.shouldFetchJokes();
  }

  void presentItems() {
    this.presenter?.presentItems(JokesModels.ItemsPresentationResponse(this.itemsToPresent(), this.paginationModel.readJokes));
  }

  List<Joke> itemsToPresent() {
    return this.paginationModel.items;
  }

  shouldVerifyNoMoreItems(int count) {
    if (count < this.paginationModel.limit) {
      this.paginationModel.noMoreItems = true;
      this.presenter?.presentNoMoreItems();
    }
  }

  Joke? joke(String? id) {
    if (id == null) {
      return null;
    }
    return this.paginationModel.items.firstWhereOrNull((element) => element.uuid == id);
  }

  @override
  void shouldSelectReadAnswer(JokesModels.ItemSelectionRequest request) {
    final joke = this.joke(request.id);
    if (joke != null) {
      this.paginationModel.readJokes.add(joke);
      this.presenter?.presentReadState(JokesModels.ItemReadStateResponse(true, joke.uuid));
    }
  }

  @override
  void shouldSelectLogo() {
    this.presenter?.presentScrollToItem(JokesModels.ItemScrollResponse(false, 0));
  }
}
