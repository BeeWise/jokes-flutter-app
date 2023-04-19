import 'package:flutter/material.dart';
import 'package:jokes/components/cells/joke/JokeQuestionAnswerCell.dart';
import 'package:jokes/components/cells/joke/JokeTextCell.dart';
import 'package:jokes/components/views/LogoNavigationView.dart';
import 'package:jokes/scenes/jokes/JokesInteractor.dart';
import 'package:jokes/scenes/jokes/JokesModels.dart' as JokesModels;
import 'package:jokes/scenes/jokes/JokesPresenter.dart';
import 'package:jokes/scenes/jokes/JokesRouter.dart';
import 'package:jokes/style/ApplicationConstraints.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../components/attributed_text/AttributedText.dart';
import '../../components/cells/space/SpaceCell.dart';
import '../../components/views/LoadingImageView.dart';
import '../../components/views/UserAvatarView.dart';
import '../../models/image/CompoundImage.dart';
import '../../style/ApplicationStyle.dart';
import 'JokesStyle.dart' hide UserAvatarViewModel;

class JokesController extends StatefulWidget {
  const JokesController({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return JokesControllerState();
  }
}

abstract class JokesDisplayLogic {
  void displayLoadingState();
  void displayNotLoadingState();

  void displayItems(JokesModels.ItemsPresentationViewModel viewModel);

  void displayNoMoreItems(JokesModels.NoMoreItemsPresentationViewModel viewModel);
  void displayRemoveNoMoreItems();

  void displayError(JokesModels.ErrorPresentationViewModel viewModel);
  void displayRemoveError();

  void displayReadState(JokesModels.ItemReadStateViewModel viewModel);

  void displayScrollToItem(JokesModels.ItemScrollViewModel viewModel);
}

class JokesControllerModel {
  List<JokesModels.DisplayedItem> displayedItems = [];

  bool isLoading = false;
  int loadingIndex = 0;

  bool hasError = false;
  int errorIndex = 0;
  AttributedText? errorText;

  bool noMoreItems = false;
  int noMoreItemsIndex = 0;
  AttributedText? noMoreItemsText;

  LogoNavigationViewModel? logoNavigation;
}

class JokesControllerState extends State<JokesController> implements JokesDisplayLogic, JokeTextCellDelegate, JokeQuestionAnswerCellDelegate, LogoNavigationViewDelegate {
  JokesBusinessLogic? interactor;
  JokesRoutingLogic? router;

  JokesControllerModel model = JokesControllerModel();
  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    this.setup();
    this.interactor?.shouldFetchJokes();
  }

  void setup() {
    final displayer = this;
    JokesPresentationLogic presenter = JokesPresenter(displayer);
    JokesInteractor interactor = JokesInteractor();
    JokesRouter router = JokesRouter();
    interactor.presenter = presenter;
    router.controller = this;
    this.interactor = interactor;
    this.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ApplicationStyle.colors.backgroundColor,
      body: Stack(children: [this.setupImageBackground(), this.setupSafeAreaView()])
    );
  }

  Widget setupImageBackground() {
    return Positioned(top: 0, bottom: 0, left: 0, right: 0, child: Image.asset(ApplicationStyle.images.wallBackgroundImage, fit: BoxFit.cover));
  }

  SafeArea setupSafeAreaView() {
    return SafeArea(child: Container(color: Colors.transparent, child: Column(children: [this.setupNavigationBar(), this.setupContentView()])));
  }

  LogoNavigationView setupNavigationBar() {
    final model = this.model.logoNavigation;
    if (model != null) {
      return LogoNavigationView(model: model, delegate: this);
    } else {
      final logoNavigation = this.setupLogoNavigationViewModel();
      this.model.logoNavigation = logoNavigation;
      return LogoNavigationView(model: logoNavigation, delegate: this);
    }
  }

  LogoNavigationViewModel setupLogoNavigationViewModel() {
    final loadingImage = LoadingImageViewModel(CompoundImage(null, null, BoxFit.cover), false);
    loadingImage.borderBottomLeftRadius = JokesStyle.instance.userAvatarViewModel.borderRadius;
    loadingImage.borderBottomRightRadius = JokesStyle.instance.userAvatarViewModel.borderRadius;
    loadingImage.borderTopLeftRadius = JokesStyle.instance.userAvatarViewModel.borderRadius;
    loadingImage.borderTopRightRadius = JokesStyle.instance.userAvatarViewModel.borderRadius;
    loadingImage.activityIndicatorColor = JokesStyle.instance.userAvatarViewModel.activityIndicatorColor;
  
    final userAvatar = UserAvatarViewModel(loadingImage);
    userAvatar.backgroundColor = JokesStyle.instance.userAvatarViewModel.backgroundColor;
    userAvatar.borderColor = JokesStyle.instance.userAvatarViewModel.borderColor;
    userAvatar.borderWidth = JokesStyle.instance.userAvatarViewModel.borderWidth;

    final model = LogoNavigationViewModel(userAvatar);
    model.includeBack = false;
    model.includeUserAvatar = false;
    model.includeSeparator = true;
    return model;
  }

  @override
  void logoNavigationViewOnPressBackButton() {

  }

  @override
  void logoNavigationViewOnPressLogoImage() {
    this.interactor?.shouldSelectLogo();
  }

  @override
  void logoNavigationViewOnPressUserAvatar() {

  }

  Widget setupContentView() {
    return Expanded(
        child: Container(color: JokesStyle.instance.contentViewModel.backgroundColor, child: this.setupRefreshIndicator()));
  }

  RefreshIndicator setupRefreshIndicator() {
    return RefreshIndicator(color: JokesStyle.instance.listViewModel.activityIndicatorColor, child: this.setupListView(), onRefresh: () async { this.interactor?.shouldRefreshDetails(); });
  }

  ScrollablePositionedList setupListView() {
    return ScrollablePositionedList.builder(
        itemCount: this.model.displayedItems.length +
            this.model.loadingIndex +
            this.model.errorIndex +
            this.model.noMoreItemsIndex,
        itemScrollController: this.itemScrollController,
        itemBuilder: (context, index) {
          if (this.model.displayedItems.length != index) {
            return this.setupCell(index);
          }
          return this.setupListViewFooter();
        });
  }

  Widget setupCell(int index) {
    if (this.model.displayedItems.isEmpty) {
      return Container();
    }
    final item = this.model.displayedItems[index];
    switch (item.type) {
      case JokesModels.ItemType.jokeText:
        return this.setupJokeTextCell(item);
      case JokesModels.ItemType.jokeQna:
        return this.setupJokeQuestionAnswerCell(item);
      case JokesModels.ItemType.space:
        return this.setupSpaceCell(item);
    }
  }

  JokeTextCell setupJokeTextCell(JokesModels.DisplayedItem item) {
    final model = item.model as JokeTextCellModel;
    return JokeTextCell(model: model, delegate: this);
  }

  @override
  void jokeTextCellOnPressLikeCount(String? id) {

  }

  @override
  void jokeTextCellOnPressDislikeCount(String? id) {

  }

  @override
  void jokeTextCellOnPressUserAvatar(String? id) {

  }

  @override
  void jokeTextCellOnPressUserName(String? id) {

  }

  JokeQuestionAnswerCell setupJokeQuestionAnswerCell(JokesModels.DisplayedItem item) {
    final model = item.model as JokeQuestionAnswerCellModel;
    return JokeQuestionAnswerCell(model: model, delegate: this);
  }

  @override
  void jokeQuestionAnswerCellOnPressLikeCount(String? id) {

  }

  @override
  void jokeQuestionAnswerCellOnPressDislikeCount(String? id) {

  }

  @override
  void jokeQuestionAnswerCellOnPressUserAvatar(String? id) {

  }

  @override
  void jokeQuestionAnswerCellOnPressUserName(String? id) {

  }

  @override
  void jokeQuestionAnswerCellOnPressReadAnswer(String? id) {
    this.interactor?.shouldSelectReadAnswer(JokesModels.ItemSelectionRequest(id));
  }

  SpaceCell setupSpaceCell(JokesModels.DisplayedItem item) {
    final model = item.model as SpaceCellModel;
    return SpaceCell(model: model);
  }

  Widget setupListViewFooter() {
    if (this.model.isLoading) {
      return this.setupActivityIndicator();
    } else if (this.model.hasError) {
      return this.setupErrorText();
    } else if (this.model.noMoreItems) {
      return this.setupNoMoreItemsText();
    }
    return Container();
  }

  Widget setupActivityIndicator() {
    return Container(margin: EdgeInsets.all(ApplicationConstraints.constant.x8), child: Center(child: CircularProgressIndicator(color: JokesStyle.instance.listViewModel.activityIndicatorColor)));
  }

  Widget setupErrorText() {
    return InkWell(onTap: () => this.interactor?.shouldFetchJokes(), child: Container(
        margin: EdgeInsets.all(ApplicationConstraints.constant.x8),
        child: Center(
            child: Text(this.model.errorText?.text ?? "",
                textAlign: this.model.errorText?.align,
                overflow: this.model.errorText?.overflow,
                style: this.model.errorText?.style))));
  }

  Widget setupNoMoreItemsText() {
    return Container(
        margin: EdgeInsets.all(ApplicationConstraints.constant.x8),
        child: Center(
            child: Text(this.model.noMoreItemsText?.text ?? "",
                textAlign: this.model.noMoreItemsText?.align,
                overflow: this.model.noMoreItemsText?.overflow,
                style: this.model.noMoreItemsText?.style)));
  }

  //#region Display logic
  @override
  void displayLoadingState() {
    this.setState(() {
      this.model.isLoading = true;
      this.model.loadingIndex = 1;
    });
  }

  @override
  void displayNotLoadingState() {
    this.setState(() {
      this.model.isLoading = false;
      this.model.loadingIndex = 0;
    });
  }

  @override
  void displayItems(JokesModels.ItemsPresentationViewModel viewModel) {
    this.setState(() {
      this.model.displayedItems = viewModel.items;
    });
  }

  @override
  void displayNoMoreItems(JokesModels.NoMoreItemsPresentationViewModel viewModel) {
    this.setState(() {
      this.model.noMoreItems = true;
      this.model.noMoreItemsIndex = 1;
      this.model.noMoreItemsText = viewModel.errorText;
    });
  }

  @override
  void displayRemoveNoMoreItems() {
    this.setState(() {
      this.model.noMoreItems = false;
      this.model.noMoreItemsIndex = 0;
      this.model.noMoreItemsText = null;
    });
  }

  @override
  void displayError(JokesModels.ErrorPresentationViewModel viewModel) {
    this.setState(() {
      this.model.hasError = true;
      this.model.errorIndex = 1;
      this.model.errorText = viewModel.errorText;
    });
  }

  @override
  void displayRemoveError() {
    this.setState(() {
      this.model.hasError = false;
      this.model.errorIndex = 0;
      this.model.errorText = null;
    });
  }

  @override
  void displayReadState(JokesModels.ItemReadStateViewModel viewModel) {
    final model = this.displayedJokeQuestionModel(JokesModels.ItemType.jokeQna, viewModel.id);
    if (model != null) {
      model.isRead = viewModel.isRead;
      model.cellInterface?.reload();
    }
  }

  @override
  void displayScrollToItem(JokesModels.ItemScrollViewModel viewModel) {
    this.itemScrollController.scrollTo(index: viewModel.index, duration: viewModel.duration);
  }
  //#endregion

  //#region Auxiliary
  JokeQuestionAnswerCellModel? displayedJokeQuestionModel(JokesModels.ItemType type, String? id) {
    for (var item in this.model.displayedItems) {
      if (item.type == type && item.model is JokeQuestionAnswerCellModel) {
        final model = item.model as JokeQuestionAnswerCellModel?;
        if (model != null && model.id == id) {
          return model;
        }
      }
    }
    return null;
  }
  //#endregion
}
