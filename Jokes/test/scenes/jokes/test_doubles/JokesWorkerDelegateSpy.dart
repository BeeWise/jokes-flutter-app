import 'package:jokes/models/joke/Joke.dart';
import 'package:jokes/operations/base/errors/OperationError.dart';
import 'package:jokes/scenes/jokes/JokesWorker.dart';

class JokesWorkerDelegateSpy implements JokesWorkerDelegate {
  bool successDidFetchJokesCalled = false;
  bool failureDidFetchJokesCalled = false;

  @override
  void successDidFetchJokes(List<Joke> jokes) {
    this.successDidFetchJokesCalled = true;
  }

  @override
  void failureDidFetchJokes(OperationError error) {
    this.failureDidFetchJokesCalled = true;
  }
}