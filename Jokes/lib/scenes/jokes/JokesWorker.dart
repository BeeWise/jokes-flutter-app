import 'package:jokes/operations/base/errors/OperationError.dart';
import 'package:jokes/operations/base/operations/Operation.dart';
import 'package:jokes/tasks/configurator/TaskConfigurator.dart';
import 'package:jokes/tasks/joke/JokeTask.dart';

import '../../models/joke/Joke.dart';

abstract class JokesWorkerDelegate {
  void successDidFetchJokes(List<Joke> jokes);
  void failureDidFetchJokes(OperationError error);
}

class JokesWorker {
  JokesWorkerDelegate? delegate;
  JokesWorker(this.delegate);

  JokeTaskProtocol jokeTask = TaskConfigurator.instance.jokeTask();

  void fetchJokes(int page, int limit, int orderBy) {
    this.jokeTask.fetchJokes(
        JokeTaskModelsFetchJokesRequest(page, limit, orderBy, null, null),
        Result((response) {
          this.delegate?.successDidFetchJokes(response.jokes);
        }, (error) {
          this.delegate?.failureDidFetchJokes(error);
        }));
  }
}
