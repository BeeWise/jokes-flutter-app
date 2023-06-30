import 'package:jokes/scenes/jokes/JokesInteractor.dart';
import 'package:jokes/scenes/jokes/JokesModels.dart' as JokesModels;

class JokesBusinessLogicSpy implements JokesBusinessLogic {
  bool shouldFetchJokesCalled = false;
  bool shouldRefreshDetailsCalled = false;
  bool shouldSelectLogoCalled = false;
  bool shouldSelectReadAnswerCalled = false;

  @override
  void shouldFetchJokes() {
    this.shouldFetchJokesCalled = true;
  }

  @override
  void shouldRefreshDetails() {
    this.shouldRefreshDetailsCalled = true;
  }

  @override
  void shouldSelectLogo() {
    this.shouldSelectLogoCalled = true;
  }

  @override
  void shouldSelectReadAnswer(JokesModels.ItemSelectionRequest request) {
    this.shouldSelectReadAnswerCalled = true;
  }
}