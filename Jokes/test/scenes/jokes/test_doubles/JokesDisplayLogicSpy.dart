import 'package:jokes/scenes/jokes/JokesController.dart';
import 'package:jokes/scenes/jokes/JokesModels.dart' as JokesModels;

class JokesDisplayLogicSpy implements JokesDisplayLogic {
  bool displayLoadingStateCalled = false;
  bool displayNotLoadingStateCalled = false;

  bool displayItemsCalled = false;
  bool displayNoMoreItemsCalled = false;
  bool displayRemoveNoMoreItemsCalled = false;

  bool displayErrorCalled = false;
  bool displayRemoveErrorCalled = false;

  bool displayReadStateCalled = false;
  bool displayScrollToItemCalled = false;

  @override
  void displayLoadingState() {
    this.displayLoadingStateCalled = true;
  }

  @override
  void displayNotLoadingState() {
    this.displayNotLoadingStateCalled = true;
  }

  @override
  void displayItems(JokesModels.ItemsPresentationViewModel viewModel) {
    this.displayItemsCalled = true;
  }

  @override
  void displayNoMoreItems(JokesModels.NoMoreItemsPresentationViewModel viewModel) {
    this.displayNoMoreItemsCalled = true;
  }

  @override
  void displayRemoveNoMoreItems() {
    this.displayRemoveNoMoreItemsCalled = true;
  }

  @override
  void displayError(JokesModels.ErrorPresentationViewModel viewModel) {
    this.displayErrorCalled = true;
  }

  @override
  void displayRemoveError() {
    this.displayRemoveErrorCalled = true;
  }

  @override
  void displayReadState(JokesModels.ItemReadStateViewModel viewModel) {
    this.displayReadStateCalled = true;
  }

  @override
  void displayScrollToItem(JokesModels.ItemScrollViewModel viewModel) {
    this.displayScrollToItemCalled = true;
  }
}