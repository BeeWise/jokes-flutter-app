import 'package:flutter/material.dart';
import 'package:jokes/scenes/jokes/JokesInteractor.dart';
import 'package:jokes/scenes/jokes/JokesLocalization.dart';
import 'package:jokes/scenes/jokes/JokesModels.dart';
import 'package:jokes/scenes/jokes/JokesPresenter.dart';

import '../../components/attributed_text/AttributedText.dart';
import '../../style/ApplicationStyle.dart';

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

  void displayItems(JokesModelsItemsPresentationViewModel viewModel);

  void displayNoMoreItems(
      JokesModelsNoMoreItemsPresentationViewModel viewModel);
  void displayRemoveNoMoreItems();

  void displayError(JokesModelsErrorPresentationViewModel viewModel);
  void displayRemoveError();
}

class JokesControllerState extends State<JokesController>
    implements JokesDisplayLogic {
  JokesBusinessLogic? interactor;

  List<JokesModelsDisplayedItem> displayedItems = [];

  bool isLoading = false;
  int loadingIndex = 0;

  bool hasError = false;
  int errorIndex = 0;
  AttributedText? errorText;

  bool noMoreItems = false;
  int noMoreItemsIndex = 0;
  AttributedText? noMoreItemsText;

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
    interactor.presenter = presenter;
    this.interactor = interactor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ApplicationStyle.colors.backgroundColor,
      body: this.setupSafeAreaView(),
    );
  }

  SafeArea setupSafeAreaView() {
    return SafeArea(child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ApplicationStyle.images.wallBackgroundImage),
                fit: BoxFit.cover)),
        child: Column(
            children: [this.setupNavigationView(), this.setupContentView()])));
  }

  Container setupNavigationView() {
    return Container(
        color: Colors.transparent,
        child: SizedBox(
            width: double.infinity,
            height: 56,
            child: FractionallySizedBox(
                alignment: Alignment.center,
                heightFactor: 0.75,
                child:
                    Image.asset(ApplicationStyle.images.neonLogoMediumImage))));
  }

  Expanded setupContentView() {
    return Expanded(
        child: Container(color: Colors.white, child: this.setupListView()));
  }

  ListView setupListView() {
    return ListView.builder(
        itemCount: this.displayedItems.length +
            this.loadingIndex +
            this.errorIndex +
            this.noMoreItemsIndex,
        itemBuilder: (context, index) {
          if (this.displayedItems.length != index) {
            return this.setupCell(index);
          }
          return this.setupListViewFooter();
        });
  }

  SizedBox setupCell(int index) {
    return SizedBox(
        width: double.infinity, child: Center(child: Text(JokesLocalization.instance.sourceText('https://page$index.com'))));
  }

  Widget? setupListViewFooter() {
    if (this.isLoading) {
      return this.setupLoadingView();
    } else if (this.hasError) {
      return this.setupErrorText();
    } else if (this.noMoreItems) {
      return this.setupNoMoreItemsText();
    }
    return null;
  }

  CircularProgressIndicator setupLoadingView() {
    return const CircularProgressIndicator.adaptive(
      backgroundColor: Colors.black,
    );
  }

  Widget setupErrorText() {
    return const SizedBox(
        width: double.infinity, child: Center(child: Text('Error text')));
  }

  Widget setupNoMoreItemsText() {
    return const SizedBox(
        width: double.infinity,
        child: Center(child: Text('No more items text')));
  }

  @override
  void displayLoadingState() {
    this.setState(() {
      this.isLoading = true;
      this.loadingIndex = 1;
    });
  }

  @override
  void displayNotLoadingState() {
    this.setState(() {
      this.isLoading = false;
      this.loadingIndex = 0;
    });
  }

  @override
  void displayItems(JokesModelsItemsPresentationViewModel viewModel) {
    this.setState(() {
      this.displayedItems = viewModel.items;
    });
  }

  @override
  void displayNoMoreItems(
      JokesModelsNoMoreItemsPresentationViewModel viewModel) {
    this.setState(() {
      this.noMoreItems = true;
      this.noMoreItemsIndex = 1;
      this.noMoreItemsText = viewModel.errorText;
    });
  }

  @override
  void displayRemoveNoMoreItems() {
    this.setState(() {
      this.noMoreItems = false;
      this.noMoreItemsIndex = 0;
      this.noMoreItemsText = null;
    });
  }

  @override
  void displayError(JokesModelsErrorPresentationViewModel viewModel) {
    this.setState(() {
      this.hasError = true;
      this.errorIndex = 1;
      this.errorText = viewModel.errorText;
    });
  }

  @override
  void displayRemoveError() {
    this.setState(() {
      this.hasError = false;
      this.errorIndex = 0;
      this.errorText = null;
    });
  }
}
