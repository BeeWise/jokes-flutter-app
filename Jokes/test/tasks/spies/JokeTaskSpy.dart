import 'package:jokes/models/joke/Joke.dart';
import 'package:jokes/operations/base/errors/OperationError.dart';
import 'package:jokes/operations/base/operations/Operation.dart';
import 'package:jokes/tasks/environment/TaskEnvironment.dart';
import 'package:jokes/tasks/joke/JokeTask.dart';

class JokeTaskSpy implements JokeTask {
  @override
  TaskEnvironment environment;

  JokeTaskSpy({this.environment = TaskEnvironment.memory});

  List<Joke> fetchedJokes = [];
  bool fetchJokesCalled = false;
  bool shouldFailFetchJokes = false;

  @override
  void fetchJokes(JokeTaskModelsFetchJokesRequest model, ResultInterface<JokeTaskModelsFetchJokesResponse> completionHandler) {
    this.fetchJokesCalled = true;

    if (this.shouldFailFetchJokes) {
      completionHandler.failure(OperationError.noDataAvailable);
    } else {
      completionHandler.success(JokeTaskModelsFetchJokesResponse(this.fetchedJokes));
    }
  }
}