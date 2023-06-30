import 'package:jokes/scenes/jokes/JokesPresenter.dart';
import 'package:jokes/scenes/jokes/JokesModels.dart' as JokesModels;

class JokesPresentationLogicSpy implements JokesPresentationLogic {
  bool presentLoadingStateCalled = false;
  bool presentNotLoadingStateCalled = false;

  bool presentItemsCalled = false;

  bool presentNoMoreItemsCalled = false;
  bool presentRemoveNoMoreItemsCalled = false;

  bool presentErrorCalled = false;
  bool presentRemoveErrorCalled = false;

  bool presentReadStateCalled = false;

  bool presentScrollToItemCalled = false;

  @override
  void presentLoadingState() {
    this.presentLoadingStateCalled = true;
  }

  @override
  void presentNotLoadingState() {
    this.presentNotLoadingStateCalled = true;
  }

  @override
  void presentItems(JokesModels.ItemsPresentationResponse response) {
    this.presentItemsCalled = true;
  }

  @override
  void presentNoMoreItems() {
    this.presentNoMoreItemsCalled = true;
  }

  @override
  void presentRemoveNoMoreItems() {
    this.presentRemoveNoMoreItemsCalled = true;
  }

  @override
  void presentError(JokesModels.ErrorPresentationResponse response) {
    this.presentErrorCalled = true;
  }

  @override
  void presentRemoveError() {
    this.presentRemoveErrorCalled = true;
  }

  @override
  void presentReadState(JokesModels.ItemReadStateResponse response) {
    this.presentReadStateCalled = true;
  }

  @override
  void presentScrollToItem(JokesModels.ItemScrollResponse response) {
    this.presentScrollToItemCalled = true;
  }
}