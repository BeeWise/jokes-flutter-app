import 'package:jokes/components/attributed_text/AttributedText.dart';
import 'package:jokes/scenes/jokes/JokesController.dart';
import 'package:flutter/material.dart';

import '../../models/joke/Joke.dart';
import 'JokesModels.dart';

abstract class JokesPresentationLogic {
  void presentLoadingState();
  void presentNotLoadingState();

  void presentItems(JokesModelsItemsPresentationResponse response);

  void presentNoMoreItems();
  void presentRemoveNoMoreItems();

  void presentError(JokesModelsErrorPresentationResponse response);
  void presentRemoveError();
}

class JokesPresenter extends JokesPresentationLogic {
  JokesDisplayLogic? displayer;
  JokesPresenter(this.displayer);

  @override
  void presentError(JokesModelsErrorPresentationResponse response) {
    const style = TextStyle(
        color: Colors.red, fontSize: 17, fontWeight: FontWeight.normal);
    this.displayer?.displayError(
        JokesModelsErrorPresentationViewModel(AttributedText('Error', style)));
  }

  @override
  void presentItems(JokesModelsItemsPresentationResponse response) {
    this.displayer?.displayItems(JokesModelsItemsPresentationViewModel(
        this.displayedItems(response.items, response.topItemModel)));
  }

  List<JokesModelsDisplayedItem> displayedItems(
      List<Joke> items, JokesModelsTopItemModel? topItemModel) {
    return items.map((element) => this.displayedItem(element)).toList();
  }

  JokesModelsDisplayedItem displayedItem(Joke joke) {
    return JokesModelsDisplayedItem(JokesModelsItemType.jokeText, null);
  }

  @override
  void presentLoadingState() {
    this.displayer?.displayLoadingState();
  }

  @override
  void presentNoMoreItems() {
    const style = TextStyle(
        color: Colors.grey, fontSize: 17, fontWeight: FontWeight.normal);
    this.displayer?.displayNoMoreItems(
        JokesModelsNoMoreItemsPresentationViewModel(
            AttributedText('No more items', style)));
  }

  @override
  void presentNotLoadingState() {
    this.displayer?.displayNotLoadingState();
  }

  @override
  void presentRemoveError() {
    this.displayer?.displayRemoveError();
  }

  @override
  void presentRemoveNoMoreItems() {
    this.displayer?.displayRemoveNoMoreItems();
  }
}
