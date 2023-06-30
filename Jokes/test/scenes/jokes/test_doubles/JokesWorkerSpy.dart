import 'package:jokes/scenes/jokes/JokesWorker.dart';

class JokesWorkerSpy extends JokesWorker {
  JokesWorkerSpy(super.delegate);

  bool fetchJokesCalled = false;

  @override
  void fetchJokes(int page, int limit, int orderBy) {
    this.fetchJokesCalled = true;
  }
}