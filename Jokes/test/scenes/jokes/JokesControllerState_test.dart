import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jokes/components/attributed_text/AttributedText.dart';
import 'package:jokes/components/cells/joke/JokeQuestionAnswerCell.dart';
import 'package:jokes/components/views/LoadingImageView.dart';
import 'package:jokes/components/views/UserAvatarView.dart';
import 'package:jokes/models/image/CompoundImage.dart';
import 'package:jokes/scenes/jokes/JokesController.dart';
import 'package:jokes/scenes/jokes/JokesModels.dart' as JokesModels;

import 'test_doubles/JokesBusinessLogicSpy.dart';
import 'test_doubles/JokesRoutingLogicSpy.dart';

void main() {
  group('JokesControllerStateTests', () {
    void setupAll() {
      WidgetsFlutterBinding.ensureInitialized();
    }

    setUpAll(() => setupAll());

    testShouldSelectLogoShouldAskTheInteractorToSelectLogo(JokesControllerState sut, JokesBusinessLogicSpy interactorSpy, JokesRoutingLogicSpy routerSpy) {
      print("testShouldSelectLogoShouldAskTheInteractorToSelectLogo");
      sut.logoNavigationViewOnPressLogoImage();
      expect(interactorSpy.shouldSelectLogoCalled, true);
    }

    testJokeQuestionAnswerCellOnPressReadAnswerShouldAskTheInteractorToSelectReadAnswer(JokesControllerState sut, JokesBusinessLogicSpy interactorSpy, JokesRoutingLogicSpy routerSpy) {
      print("testJokeQuestionAnswerCellOnPressReadAnswerShouldAskTheInteractorToSelectReadAnswer");
      sut.jokeQuestionAnswerCellOnPressReadAnswer('id');
      expect(interactorSpy.shouldSelectReadAnswerCalled, true);
    }

    testDisplayLoadingStateShouldUpdateIsLoading(JokesControllerState sut, JokesBusinessLogicSpy interactorSpy, JokesRoutingLogicSpy routerSpy) {
      print("testDisplayLoadingStateShouldUpdateIsLoading");
      sut.model.isLoading = false;
      sut.displayLoadingState();
      expect(sut.model.isLoading, true);
    }

    testDisplayNotLoadingStateShouldUpdateIsLoading(JokesControllerState sut, JokesBusinessLogicSpy interactorSpy, JokesRoutingLogicSpy routerSpy) {
      print("testDisplayNotLoadingStateShouldUpdateIsLoading");
      sut.model.isLoading = true;
      sut.displayNotLoadingState();
      expect(sut.model.isLoading, false);
    }

    testDisplayItemsShouldUpdateDisplayedItems(JokesControllerState sut, JokesBusinessLogicSpy interactorSpy, JokesRoutingLogicSpy routerSpy) {
      print("testDisplayItemsShouldUpdateDisplayedItems");
      final items = [JokesModels.DisplayedItem(JokesModels.ItemType.jokeText, null)];
      sut.model.displayedItems = items;
      sut.displayItems(JokesModels.ItemsPresentationViewModel(items));
      expect(sut.model.displayedItems.length, items.length);
    }

    testDisplayNoMoreItemsShouldUpdateNoMoreItems(JokesControllerState sut, JokesBusinessLogicSpy interactorSpy, JokesRoutingLogicSpy routerSpy) {
      print("testDisplayNoMoreItemsShouldUpdateNoMoreItems");
      sut.model.noMoreItemsText = null;
      sut.model.noMoreItems = false;
      final text = AttributedText('text', const TextStyle());
      sut.displayNoMoreItems(JokesModels.NoMoreItemsPresentationViewModel(text));
      expect(sut.model.noMoreItems, true);
      expect(sut.model.noMoreItemsText, text);
    }

    testDisplayRemoveNoMoreItemsShouldUpdateNoMoreItems(JokesControllerState sut, JokesBusinessLogicSpy interactorSpy, JokesRoutingLogicSpy routerSpy) {
      print("testDisplayRemoveNoMoreItemsShouldUpdateNoMoreItems");
      sut.model.noMoreItemsText = AttributedText('text', const TextStyle());
      sut.model.noMoreItems = true;
      sut.displayRemoveNoMoreItems();
      expect(sut.model.noMoreItems, false);
      expect(sut.model.noMoreItemsText, null);
    }

    testDisplayErrorShouldUpdateError(JokesControllerState sut, JokesBusinessLogicSpy interactorSpy, JokesRoutingLogicSpy routerSpy) {
      print("testDisplayErrorShouldUpdateError");
      sut.model.errorText = null;
      sut.model.hasError = false;
      final text = AttributedText('text', const TextStyle());
      sut.displayError(JokesModels.ErrorPresentationViewModel(text));
      expect(sut.model.hasError, true);
      expect(sut.model.errorText, text);
    }

    testDisplayRemoveErrorShouldUpdateError(JokesControllerState sut, JokesBusinessLogicSpy interactorSpy, JokesRoutingLogicSpy routerSpy) {
      print("testDisplayRemoveErrorShouldUpdateError");
      sut.model.errorText = AttributedText('text', const TextStyle());
      sut.model.hasError = true;
      sut.displayRemoveError();
      expect(sut.model.hasError, false);
      expect(sut.model.errorText, null);
    }

    testDisplayReadStateShouldUpdateIsReadForJokeQnaModel(JokesControllerState sut, JokesBusinessLogicSpy interactorSpy, JokesRoutingLogicSpy routerSpy) {
      print("testDisplayReadStateShouldUpdateIsReadForJokeQnaModel");
      const isRead = true;
      const uuid = 'jokeId';

      final model = JokeQuestionAnswerCellModel(UserAvatarViewModel(LoadingImageViewModel(CompoundImage(null, null, BoxFit.cover), false)));
      model.isRead = false;
      model.id = uuid;

      final item = JokesModels.DisplayedItem(JokesModels.ItemType.jokeQna, model);
      sut.model.displayedItems = [item];

      sut.displayReadState(JokesModels.ItemReadStateViewModel(isRead, uuid));
      expect(model.isRead, isRead);
    }

    testWidgets('JokesControllerStateTests', (widgetTester) async {
      print("Running 10 tests...");

      const key = Key('controller');
      await widgetTester.pumpWidget(const MaterialApp(home: JokesController(key: key)));
      await widgetTester.pumpAndSettle(const Duration(seconds: 5));

      final JokesControllerState sut = widgetTester.state(find.byKey(key));
      late JokesBusinessLogicSpy interactorSpy = JokesBusinessLogicSpy();
      late JokesRoutingLogicSpy routerSpy = JokesRoutingLogicSpy();

      sut.interactor = interactorSpy;
      sut.router = routerSpy;

      testShouldSelectLogoShouldAskTheInteractorToSelectLogo(sut, interactorSpy, routerSpy);
      testJokeQuestionAnswerCellOnPressReadAnswerShouldAskTheInteractorToSelectReadAnswer(sut, interactorSpy, routerSpy);
      testDisplayLoadingStateShouldUpdateIsLoading(sut, interactorSpy, routerSpy);
      testDisplayNotLoadingStateShouldUpdateIsLoading(sut, interactorSpy, routerSpy);
      testDisplayItemsShouldUpdateDisplayedItems(sut, interactorSpy, routerSpy);
      testDisplayNoMoreItemsShouldUpdateNoMoreItems(sut, interactorSpy, routerSpy);
      testDisplayRemoveNoMoreItemsShouldUpdateNoMoreItems(sut, interactorSpy, routerSpy);
      testDisplayErrorShouldUpdateError(sut, interactorSpy, routerSpy);
      testDisplayRemoveErrorShouldUpdateError(sut, interactorSpy, routerSpy);
      testDisplayReadStateShouldUpdateIsReadForJokeQnaModel(sut, interactorSpy, routerSpy);
    });
  });
}