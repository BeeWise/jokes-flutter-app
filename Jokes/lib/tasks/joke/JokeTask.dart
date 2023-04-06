import 'package:jokes/operations/base/operations/AsynchronousOperation.dart';
import 'package:jokes/operations/base/operations/Operation.dart';
import 'package:jokes/operations/base/operations/OperationQueue.dart';
import 'package:jokes/tasks/environment/TaskEnvironment.dart';
import 'package:jokes/tasks/task_protocol/TaskProtocol.dart';

import '../../models/joke/Joke.dart';
import '../../operations/jokes/FetchJokesOperation.dart';

class JokeTaskModelsFetchJokesRequest {
  final int page;
  final int limit;
  final int orderBy;
  final String? startedAt;
  final String? endedAt;

  const JokeTaskModelsFetchJokesRequest(
      this.page, this.limit, this.orderBy, this.startedAt, this.endedAt);
}

class JokeTaskModelsFetchJokesResponse {
  final List<Joke> jokes;

  const JokeTaskModelsFetchJokesResponse(this.jokes);
}

abstract class JokeTaskProtocol implements TaskProtocol {
  void fetchJokes(JokeTaskModelsFetchJokesRequest model,
      ResultInterface<JokeTaskModelsFetchJokesResponse> completionHandler);
}

class JokeTask implements JokeTaskProtocol {
  @override
  TaskEnvironment environment;

  JokeTask(this.environment);

  OperationQueue fetchJokesOperationQueue = OperationQueue();

  @override
  void fetchJokes(JokeTaskModelsFetchJokesRequest model,
      ResultInterface<JokeTaskModelsFetchJokesResponse> completionHandler) {
    final operationModel = FetchJokesOperationModelsRequest(
        model.page, model.limit, model.orderBy, model.startedAt, model.endedAt);
    final operation =
        this.fetchJokesOperation(operationModel, completionHandler);
    this.fetchJokesOperationQueue.addOperation(operation);
  }

  AsynchronousOperation<FetchJokesOperationModelsResponse> fetchJokesOperation(
      FetchJokesOperationModelsRequest model,
      ResultInterface<JokeTaskModelsFetchJokesResponse> completionHandler) {
    ResultInterface<FetchJokesOperationModelsResponse>
        operationCompletionHandler =
        Result<FetchJokesOperationModelsResponse>((response) {
      completionHandler
          .success(JokeTaskModelsFetchJokesResponse(response.toJokes()));
    }, (error) {
      completionHandler.failure(error);
    });

    switch (this.environment) {
      case TaskEnvironment.production:
        {
          return FetchJokesOperation(model, operationCompletionHandler);
        }
      case TaskEnvironment.development:
        {
          return FetchJokesOperation(model, operationCompletionHandler);
        }
      case TaskEnvironment.memory:
        {
          return FetchJokesLocalOperation(model, operationCompletionHandler);
        }
    }
  }
}
