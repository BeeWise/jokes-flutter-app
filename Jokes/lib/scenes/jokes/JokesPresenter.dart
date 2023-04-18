import 'package:collection/collection.dart';
import 'package:jiffy/jiffy.dart';
import 'package:jokes/components/attributed_text/AttributedText.dart';
import 'package:jokes/models/image/CompoundImage.dart';
import 'package:jokes/scenes/jokes/JokesController.dart';
import 'package:flutter/material.dart';
import 'package:jokes/scenes/jokes/JokesModels.dart' as JokesModels;

import '../../components/buttons/ImageTitleButton.dart';
import '../../components/cells/joke/JokeQuestionAnswerCell.dart';
import '../../components/cells/joke/JokeTextCell.dart';
import '../../components/cells/space/SpaceCell.dart';
import '../../components/views/LoadingImageView.dart';
import '../../components/views/UserAvatarView.dart';
import '../../models/joke/Joke.dart';
import '../../models/user/User.dart';
import '../../style/ApplicationConstraints.dart';
import '../application/ApplicationLocalization.dart';
import 'JokesLocalization.dart';
import 'JokesStyle.dart' hide UserAvatarViewModel;

abstract class JokesPresentationLogic {
  void presentLoadingState();

  void presentNotLoadingState();

  void presentItems(JokesModels.ItemsPresentationResponse response);

  void presentNoMoreItems();

  void presentRemoveNoMoreItems();

  void presentError(JokesModels.ErrorPresentationResponse response);

  void presentRemoveError();

  void presentReadState(JokesModels.ItemReadStateResponse response);

  void presentErrorActionAlert(JokesModels.ActionAlertPresentationResponse response);

  void presentScrollToItem(JokesModels.ItemScrollResponse response);
}

class JokesPresenter extends JokesPresentationLogic {
  JokesDisplayLogic? displayer;

  JokesPresenter(this.displayer);

  @override
  void presentLoadingState() {
    this.displayer?.displayLoadingState();
  }

  @override
  void presentNotLoadingState() {
    this.displayer?.displayNotLoadingState();
  }

  @override
  void presentItems(JokesModels.ItemsPresentationResponse response) {
    this.displayer?.displayItems(JokesModels.ItemsPresentationViewModel(this.displayedItems(response.items, response.readJokes)));
  }

  @override
  void presentNoMoreItems() {
    final text = AttributedText(JokesLocalization.instance.noMoreItemsText(), JokesStyle.instance.listViewModel.noMoreItemsTextStyle);
    text.align = TextAlign.center;
    this.displayer?.displayNoMoreItems(JokesModels.NoMoreItemsPresentationViewModel(text));
  }

  @override
  void presentRemoveNoMoreItems() {
    this.displayer?.displayRemoveNoMoreItems();
  }

  @override
  void presentError(JokesModels.ErrorPresentationResponse response) {
    final text = AttributedText(JokesLocalization.instance.errorText(), JokesStyle.instance.listViewModel.errorTextStyle);
    text.align = TextAlign.center;
    this.displayer?.displayError(JokesModels.ErrorPresentationViewModel(text));
  }

  @override
  void presentRemoveError() {
    this.displayer?.displayRemoveError();
  }

  @override
  void presentReadState(JokesModels.ItemReadStateResponse response) {
    this.displayer?.displayReadState(JokesModels.ItemReadStateViewModel(response.isRead, response.id));
  }

  @override
  void presentErrorActionAlert(JokesModels.ActionAlertPresentationResponse response) {
    final message = response.error.localizedMessage();
    this.displayer?.displayErrorActionAlert(JokesModels.ActionAlertPresentationViewModel(null, message));
  }

  @override
  void presentScrollToItem(JokesModels.ItemScrollResponse response) {
    final duration = response.animated ? const Duration(seconds: 1) : const Duration(milliseconds: 1);
    this.displayer?.displayScrollToItem(JokesModels.ItemScrollViewModel(duration, response.index));
  }

  //#region Items
  List<JokesModels.DisplayedItem> displayedItems(List<Joke> items, List<Joke> readJokes) {
    if (items.isEmpty) {
      return [];
    }
    final List<JokesModels.DisplayedItem?> displayedItems = [];
    displayedItems.add(this.displayedSpaceItem(ApplicationConstraints.constant.x16));

    items.forEachIndexed((index, joke) {
      final isRead = readJokes.any((element) => joke.uuid == element.uuid);
      displayedItems.add(this.displayedJokeItem(joke, isRead));

      if (index != items.length - 1) {
        displayedItems.add(this.displayedSpaceItem(ApplicationConstraints.constant.x16));
      }
    });

    return displayedItems.whereNotNull().toList();
  }

  JokesModels.DisplayedItem displayedSpaceItem(double height) {
    return JokesModels.DisplayedItem(JokesModels.ItemType.space, SpaceCellModel(height));
  }
  //#endregion

  //#region Joke
  JokesModels.DisplayedItem displayedJokeItem(Joke joke, bool isRead) {
    if (joke.type == JokeType.qna.value && joke.answer != null) {
      return this.displayedJokeQnaItem(joke, isRead);
    }
    return this.displayedJokeTextItem(joke);
  }
  //#endregion

  //#region Joke text
  JokesModels.DisplayedItem displayedJokeTextItem(Joke joke) {
    final avatar = this.jokeAvatarViewModel(joke);
    final likeCount = this.jokeLikeViewModel(joke);
    final dislikeCount = this.jokeDislikeViewModel(joke);

    final model = JokeTextCellModel(avatar);
    model.id = joke.uuid;
    model.name = AttributedText(joke.user?.name, JokesStyle.instance.jokeCellModel.nameStyle);
    model.username = AttributedText(this.usernameText(joke.user), JokesStyle.instance.jokeCellModel.usernameStyle);
    model.text = AttributedText(joke.text, JokesStyle.instance.jokeCellModel.textStyle);
    model.likeCount = likeCount;
    model.dislikeCount = dislikeCount;
    model.time = AttributedText(this.time(joke.createdAt), JokesStyle.instance.jokeCellModel.timeStyle);
    return JokesModels.DisplayedItem(JokesModels.ItemType.jokeText, model);
  }
  //#endregion

  //#region Joke qna
  JokesModels.DisplayedItem displayedJokeQnaItem(Joke joke, bool isRead) {
    final avatar = this.jokeAvatarViewModel(joke);
    final likeCount = this.jokeLikeViewModel(joke);
    final dislikeCount = this.jokeDislikeViewModel(joke);

    final model = JokeQuestionAnswerCellModel(avatar);
    model.id = joke.uuid;
    model.name = AttributedText(joke.user?.name, JokesStyle.instance.jokeCellModel.nameStyle);
    model.username = AttributedText(this.usernameText(joke.user), JokesStyle.instance.jokeCellModel.usernameStyle);
    model.text = AttributedText(joke.text, JokesStyle.instance.jokeCellModel.textStyle);
    model.answer = AttributedText(joke.answer, JokesStyle.instance.jokeCellModel.answerStyle);
    model.likeCount = likeCount;
    model.dislikeCount = dislikeCount;
    model.time = AttributedText(this.time(joke.createdAt), JokesStyle.instance.jokeCellModel.timeStyle);
    model.isRead = isRead;
    return JokesModels.DisplayedItem(JokesModels.ItemType.jokeQna, model);
  }
  //#endregion

  UserAvatarViewModel jokeAvatarViewModel(Joke joke) {
    final loadingImage = LoadingImageViewModel(this.compoundImage(joke.user?.photo?.url150, JokesStyle.instance.jokeCellModel.avatarPlaceholder), false);
    loadingImage.activityIndicatorColor = JokesStyle.instance.jokeCellModel.avatarActivityColor;
    loadingImage.borderTopLeftRadius = JokesStyle.instance.jokeCellModel.avatarBorderRadius;
    loadingImage.borderTopRightRadius = JokesStyle.instance.jokeCellModel.avatarBorderRadius;
    loadingImage.borderBottomLeftRadius = JokesStyle.instance.jokeCellModel.avatarBorderRadius;
    loadingImage.borderBottomRightRadius = JokesStyle.instance.jokeCellModel.avatarBorderRadius;

    final avatar = UserAvatarViewModel(loadingImage);
    avatar.isDisabled = true;
    avatar.backgroundColor = JokesStyle.instance.jokeCellModel.avatarBackgroundColor;
    avatar.borderWidth = JokesStyle.instance.jokeCellModel.avatarBorderWidth;
    avatar.borderColor = JokesStyle.instance.jokeCellModel.avatarBorderColor;
    avatar.margin = JokesStyle.instance.jokeCellModel.avatarMargin;
    return avatar;
  }

  ImageTitleButtonModel jokeLikeViewModel(Joke joke) {
    final likeCount = ImageTitleButtonModel();
    likeCount.activityIndicatorColor = JokesStyle.instance.jokeCellModel.likeCountActivityColor;
    likeCount.image = CompoundImage(null, JokesStyle.instance.jokeCellModel.likeCountImage, BoxFit.contain);
    likeCount.imageTintColor = JokesStyle.instance.jokeCellModel.unselectedLikeCountTintColor;
    likeCount.backgroundColor = JokesStyle.instance.jokeCellModel.unselectedLikeCountBackgroundColor;
    likeCount.title = AttributedText(joke.likeCount.toString(), JokesStyle.instance.jokeCellModel.unselectedLikeCountStyle);
    likeCount.borderRadius = ApplicationConstraints.constant.x12;
    likeCount.borderWidth = 0;
    likeCount.isDisabled = true;
    likeCount.isLoading = false;
    return likeCount;
  }

  ImageTitleButtonModel jokeDislikeViewModel(Joke joke) {
    final dislikeCount = ImageTitleButtonModel();
    dislikeCount.activityIndicatorColor = JokesStyle.instance.jokeCellModel.dislikeCountActivityColor;
    dislikeCount.image = CompoundImage(null, JokesStyle.instance.jokeCellModel.dislikeCountImage, BoxFit.contain);
    dislikeCount.imageTintColor = JokesStyle.instance.jokeCellModel.unselectedDislikeCountTintColor;
    dislikeCount.backgroundColor = JokesStyle.instance.jokeCellModel.unselectedDislikeCountBackgroundColor;
    dislikeCount.title = AttributedText(joke.dislikeCount.toString(), JokesStyle.instance.jokeCellModel.unselectedDislikeCountStyle);
    dislikeCount.borderRadius = ApplicationConstraints.constant.x12;
    dislikeCount.borderWidth = 0;
    dislikeCount.isDisabled = true;
    dislikeCount.isLoading = false;
    return dislikeCount;
  }

  CompoundImage compoundImage(String? url, String? placeholder) {
    if (url != null && url.isNotEmpty) {
      return CompoundImage(url, placeholder, BoxFit.cover);
    }
    return CompoundImage(null, placeholder, BoxFit.cover);
  }

  String? time(String? createdAt) {
    if (createdAt == null || createdAt.isEmpty) {
      return null;
    }
    return Jiffy.parse(createdAt, pattern: "yyyy-MM-dd'T'HH:mm:ss'Z'").fromNow();
  }

  String? usernameText(User? user) {
    final username = user?.username;
    if (username != null) {
      return ApplicationLocalization.instance.usernameTitle(username);
    }
    return null;
  }
}
