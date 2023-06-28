import 'package:flutter_test/flutter_test.dart';
import 'package:jokes/models/joke/Joke.dart';
import 'package:jokes/scenes/jokes/JokesInteractor.dart';
import 'package:jokes/scenes/jokes/JokesModels.dart' as JokesModels;

import 'test_doubles/JokesPresentationLogicSpy.dart';
import 'test_doubles/JokesWorkerSpy.dart';

void main() {
  group('JokesInteractorTests', () {
    late JokesInteractor sut;
    late JokesPresentationLogicSpy presenterSpy;
    late JokesWorkerSpy workerSpy;

    void setup() {
      sut = JokesInteractor();
      presenterSpy = JokesPresentationLogicSpy();
      sut.presenter = presenterSpy;
      workerSpy = JokesWorkerSpy(sut);
      sut.worker = workerSpy;
    }

    setUp(() => setup());

    test('testShouldFetchJokesShouldSetIsFetchingItemsToTrueForPaginationModel', () {
      sut.paginationModel.isFetchingItems = false;
      sut.paginationModel.noMoreItems = false;
      sut.shouldFetchJokes();
      expect(sut.paginationModel.isFetchingItems, true);
    });

    test('testShouldFetchJokesShouldAskThePresenterToPresentLoadingStateWhenItIsNotFetchingItemsAndThereAreMoreItems', () {
      sut.paginationModel.isFetchingItems = false;
      sut.paginationModel.noMoreItems = false;
      sut.shouldFetchJokes();
      expect(presenterSpy.presentLoadingStateCalled, true);
    });

    test('testShouldFetchJokesShouldAskTheWorkerToFetchJokesWhenItIsNotFetchingItemsAndThereAreMoreItems', () {
      sut.paginationModel.isFetchingItems = false;
      sut.paginationModel.noMoreItems = false;
      sut.shouldFetchJokes();
      expect(workerSpy.fetchJokesCalled, true);
    });

    test('testSuccessDidFetchJokesShouldSetIsFetchingItemsToFalseForPaginationModel', () {
      sut.paginationModel.isFetchingItems = true;
      sut.successDidFetchJokes([]);
      expect(sut.paginationModel.isFetchingItems, false);
    });

    test('testSuccessDidFetchJokesShouldUpdateJokesForPaginationModel', () {
      final items = [Joke(), Joke(), Joke()];
      final itemsLength = items.length;
      sut.paginationModel.items = items;

      final jokes = [Joke(), Joke(), Joke()];
      final jokesLength = jokes.length;
      sut.successDidFetchJokes(jokes);
      expect(sut.paginationModel.items.length, itemsLength + jokesLength);
    });

    test('testSuccessDidFetchJokesShouldIncrementCurrentPageForPaginationModel', () {
      const currentPage = 0;
      sut.paginationModel.currentPage = currentPage;
      sut.successDidFetchJokes([]);
      expect(sut.paginationModel.currentPage, currentPage + 1);
    });

    test('testSuccessDidFetchJokesShouldSetHasErrorToFalseForPaginationModel', () {
      sut.paginationModel.hasError = true;
      sut.successDidFetchJokes([]);
      expect(sut.paginationModel.hasError, false);
    });

    test('testSuccessDidFetchJokesShouldAskThePresenterToPresentNotLoadingState', () {
      sut.successDidFetchJokes([]);
      expect(presenterSpy.presentNotLoadingStateCalled, true);
    });

    test('testSuccessDidFetchJokesShouldAskThePresenterToPresentItems', () {
      sut.successDidFetchJokes([]);
      expect(presenterSpy.presentItemsCalled, true);
    });

    test('testSuccessDidFetchJokesShouldAskThePresenterToPresentRemoveError', () {
      sut.successDidFetchJokes([]);
      expect(presenterSpy.presentRemoveErrorCalled, true);
    });

    test('testSuccessDidFetchJokesShouldSetNoMoreItemsToTrueForPaginationModelWhenLimitReached', () {
      sut.paginationModel.limit = 10;
      sut.paginationModel.noMoreItems = false;
      sut.successDidFetchJokes([]);
      expect(sut.paginationModel.noMoreItems, true);
    });

    test('testSuccessDidFetchJokesShouldAskThePresenterToPresentNoMoreItemsWhenLimitReached', () {
      sut.paginationModel.limit = 10;
      sut.successDidFetchJokes([]);
      expect(presenterSpy.presentNoMoreItemsCalled, true);
    });

    test('testShouldRefreshDetailsShouldResetPaginationModel', () {
      sut.paginationModel.isFetchingItems = true;
      sut.paginationModel.noMoreItems = true;
      sut.paginationModel.hasError = true;
      sut.paginationModel.currentPage = 10;
      sut.paginationModel.limit = 100;
      sut.paginationModel.items = [Joke(), Joke(), Joke()];
      sut.paginationModel.readJokes = [Joke(), Joke()];

      sut.shouldRefreshDetails();
      expect(sut.paginationModel.noMoreItems, false);
      expect(sut.paginationModel.hasError, false);
      expect(sut.paginationModel.currentPage, 0);
      expect(sut.paginationModel.limit, 10);
      expect(sut.paginationModel.items.length, 0);
      expect(sut.paginationModel.readJokes.length, 0);
    });

    test('testShouldRefreshDetailsShouldAskThePresenterToPresentItems', () {
      sut.shouldRefreshDetails();
      expect(presenterSpy.presentItemsCalled, true);
    });

    test('testShouldRefreshDetailsShouldAskThePresenterToPresentRemoveError', () {
      sut.shouldRefreshDetails();
      expect(presenterSpy.presentRemoveErrorCalled, true);
    });

    test('testShouldRefreshDetailsShouldAskThePresenterToPresentRemoveNoMoreItems', () {
      sut.shouldRefreshDetails();
      expect(presenterSpy.presentRemoveNoMoreItemsCalled, true);
    });

    test('testShouldRefreshDetailsShouldSetIsFetchingItemsToTrueForPaginationModel', () {
      sut.paginationModel.isFetchingItems = false;
      sut.paginationModel.noMoreItems = false;
      sut.shouldRefreshDetails();
      expect(sut.paginationModel.isFetchingItems, true);
    });

    test('testShouldRefreshDetailsShouldAskThePresenterToPresentLoadingStateWhenItIsNotFetchingItemsAndThereAreMoreItems', () {
      sut.paginationModel.isFetchingItems = false;
      sut.paginationModel.noMoreItems = false;
      sut.shouldRefreshDetails();
      expect(presenterSpy.presentLoadingStateCalled, true);
    });

    test('testShouldRefreshDetailsShouldAskTheWorkerToFetchJokesWhenItIsNotFetchingItemsAndThereAreMoreItems', () {
      sut.paginationModel.isFetchingItems = false;
      sut.paginationModel.noMoreItems = false;
      sut.shouldRefreshDetails();
      expect(workerSpy.fetchJokesCalled, true);
    });

    test('testShouldSelectReadAnswerShouldUpdateReadJokesForPaginationModel', () {
      const uuid = 'jokeId';
      final joke = Joke();
      joke.uuid = uuid;
      final jokes = [joke];
      sut.paginationModel.items = jokes;
      sut.paginationModel.readJokes = [];

      sut.shouldSelectReadAnswer(JokesModels.ItemSelectionRequest(uuid));
      expect(sut.paginationModel.readJokes.length, jokes.length);
    });

    test('testShouldSelectReadAnswerShouldAskThePresenterToPresentReadState', () {
      const uuid = 'jokeId';
      final joke = Joke();
      joke.uuid = uuid;
      sut.paginationModel.items = [joke];

      sut.shouldSelectReadAnswer(JokesModels.ItemSelectionRequest(uuid));
      expect(presenterSpy.presentReadStateCalled, true);
    });

    test('testShouldSelectLogoShouldAskThePresenterToPresentScrollToItem', () {
      sut.shouldSelectLogo();
      expect(presenterSpy.presentScrollToItemCalled, true);
    });
  });
}