import 'dart:math';

import 'package:http/http.dart';
import 'package:jokes/models/joke/Joke.dart';
import 'package:jokes/operations/base/builders/EndpointsBuilder.dart';
import 'package:jokes/operations/base/builders/OperationRequestBuilder.dart';
import 'package:jokes/operations/base/operations/AsynchronousOperation.dart';
import 'package:jokes/operations/base/operations/Operation.dart';

class FetchJokesOperationModelsRequest {
  final int page;
  final int limit;
  final int orderBy;
  final String? startedAt;
  final String? endedAt;

  const FetchJokesOperationModelsRequest(
      this.page, this.limit, this.orderBy, this.startedAt, this.endedAt);
}

class FetchJokesOperationModelsResponse {
  List<dynamic>? data;

  FetchJokesOperationModelsResponse();

  factory FetchJokesOperationModelsResponse.fromJson(
      Map<String, dynamic> json) {
    final response = FetchJokesOperationModelsResponse();
    response.data = json["data"];
    return response;
  }

  List<Joke> toJokes() {
    if (this.data != null) {
      List<Joke> jokes = [];
      for (var element in this.data!) {
        jokes.add(Joke.fromJson(element));
      }
      return jokes;
    }
    return [];
  }
}

class FetchJokesOperationRequestBuilder
    extends OperationRequestBuilder<FetchJokesOperationModelsRequest> {
  FetchJokesOperationRequestBuilder(model) : super(model);

  @override
  String url() {
    return EndpointsBuilder.instance.jokesEndpoint();
  }

  @override
  String httpMethod() {
    return HTTPMethod.get;
  }

  @override
  bool requiresAuthorization() {
    return false;
  }

  @override
  Map<String, String?> queryParameters() {
    Map<String, String> parameters = {};
    parameters['page'] = this.model.page.toString();
    parameters['limit'] = this.model.limit.toString();
    parameters['order_by'] = this.model.orderBy.toString();
    if (this.model.startedAt != null) {
      parameters['started_at'] = this.model.startedAt!;
    }
    if (this.model.endedAt != null) {
      parameters['ended_at'] = this.model.endedAt!;
    }
    return parameters;
  }
}

class FetchJokesOperation
    extends AsynchronousOperation<FetchJokesOperationModelsResponse> {
  FetchJokesOperation(FetchJokesOperationModelsRequest? model,
      ResultInterface<FetchJokesOperationModelsResponse>? completionHandler)
      : super(model, completionHandler);

  @override
  parse(body) {
    return FetchJokesOperationModelsResponse.fromJson(body);
  }

  @override
  Future<Response> request() {
    return FetchJokesOperationRequestBuilder(this.model).request();
  }
}

class FetchJokesLocalOperation extends FetchJokesOperation {
  FetchJokesLocalOperation(FetchJokesOperationModelsRequest? model,
      ResultInterface<FetchJokesOperationModelsResponse>? completionHandler)
      : super(model, completionHandler);

  bool shouldFail = false;
  int delay = Random().nextInt(2000) + 1000;

  @override
  Future<void> run(Function? completion) {
    return Future.delayed(Duration(milliseconds: this.delay), () {
      if (this.shouldFail) {
        this.noDataAvailableErrorBlock();
      } else {
        final response = FetchJokesOperationModelsResponse();
        this.successfulResultBlock(response);
      }
    });
  }
}
