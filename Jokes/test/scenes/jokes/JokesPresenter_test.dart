import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jokes/operations/base/errors/OperationError.dart';
import 'package:jokes/scenes/jokes/JokesPresenter.dart';
import 'package:jokes/scenes/jokes/JokesModels.dart' as JokesModels;

import 'test_doubles/JokesDisplayLogicSpy.dart';

void main() {
  group('JokesPresenterTests', () {
    late JokesPresenter sut;
    late JokesDisplayLogicSpy displaySpy;

    void setup() {
      displaySpy = JokesDisplayLogicSpy();
      sut = JokesPresenter(displaySpy);
    }

    void setupAll() {
      WidgetsFlutterBinding.ensureInitialized();
    }

    setUp(() => setup());

    setUpAll(() => setupAll());

    test('testPresentLoadingStateShouldAskTheDisplayerToDisplayLoadingState', () {
      sut.presentLoadingState();
      expect(displaySpy.displayLoadingStateCalled, true);
    });

    test('testPresentNotLoadingStateShouldAskTheDisplayerToDisplayNotLoadingState', () {
      sut.presentNotLoadingState();
      expect(displaySpy.displayNotLoadingStateCalled, true);
    });

    test('testPresentItemsShouldAskTheDisplayerToDisplayItems', () {
      sut.presentItems(JokesModels.ItemsPresentationResponse([], []));
      expect(displaySpy.displayItemsCalled, true);
    });

    test('testPresentNoMoreItemsShouldAskTheDisplayerToDisplayNoMoreItems', () {
      sut.presentNoMoreItems();
      expect(displaySpy.displayNoMoreItemsCalled, true);
    });

    test('testPresentRemoveNoMoreItemsShouldAskTheDisplayerToDisplayRemoveNoMoreItems', () {
      sut.presentRemoveNoMoreItems();
      expect(displaySpy.displayRemoveNoMoreItemsCalled, true);
    });

    test('testPresentErrorShouldAskTheDisplayerToDisplayError', () {
      sut.presentError(JokesModels.ErrorPresentationResponse(OperationError.noDataAvailable));
      expect(displaySpy.displayErrorCalled, true);
    });

    test('testPresentRemoveErrorShouldAskTheDisplayerToDisplayRemoveError', () {
      sut.presentRemoveError();
      expect(displaySpy.displayRemoveErrorCalled, true);
    });

    test('testPresentReadStateShouldAskTheDisplayerToDisplayReadState', () {
      sut.presentReadState(JokesModels.ItemReadStateResponse(true, 'id'));
      expect(displaySpy.displayReadStateCalled, true);
    });

    test('testPresentScrollToItemShouldAskTheDisplayerToDisplayScrollToItem', () {
      sut.presentScrollToItem(JokesModels.ItemScrollResponse(false, 0));
      expect(displaySpy.displayScrollToItemCalled, true);
    });
  });
}