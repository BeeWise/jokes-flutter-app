import 'package:flutter_test/flutter_test.dart';
import 'package:jokes/scenes/jokes/JokesWorker.dart';

import '../../tasks/spies/JokeTaskSpy.dart';
import 'test_doubles/JokesWorkerDelegateSpy.dart';

void main() {
  group('JokesWorkerTests', () {
    late JokesWorker sut;
    late JokesWorkerDelegateSpy delegateSpy;

    void setup() {
      delegateSpy = JokesWorkerDelegateSpy();
      sut = JokesWorker(delegateSpy);
    }

    setUp(() => setup());

    test('testFetchJokesShouldAskTheJokeTaskToFetchJokes', () {
      final taskSpy = JokeTaskSpy();
      sut.jokeTask = taskSpy;
      sut.fetchJokes(1, 10, 0);
      expect(taskSpy.fetchJokesCalled, true);
    });

    test('testFetchJokesShouldAskTheDelegateToSendJokesForSuccessCase', () {
      final taskSpy = JokeTaskSpy();
      taskSpy.shouldFailFetchJokes = false;
      sut.jokeTask = taskSpy;
      sut.fetchJokes(1, 10, 0);
      expect(delegateSpy.successDidFetchJokesCalled, true);
    });

    test('testFetchJokesShouldAskTheDelegateToSendErrorForFailureCase', () {
      final taskSpy = JokeTaskSpy();
      taskSpy.shouldFailFetchJokes = true;
      sut.jokeTask = taskSpy;
      sut.fetchJokes(1, 10, 0);
      expect(delegateSpy.failureDidFetchJokesCalled, true);
    });
  });
}