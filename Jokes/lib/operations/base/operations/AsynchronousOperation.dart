import 'dart:convert';

import 'package:http/http.dart';
import '../../../operations/base/errors/OperationError.dart';
import '../../../operations/base/operations/Operation.dart';
import '../../../operations/base/operations/OperationStatusCode.dart';

abstract class AsynchronousOperationInterface<T> {
  Future<Response> request();
  T? parse(dynamic body);
}

class AsynchronousOperation<T> extends Operation
    implements AsynchronousOperationInterface<T> {
  Object? model;
  ResultInterface<T>? completionHandler;

  AsynchronousOperation(this.model, this.completionHandler);

  @override
  Future<Response> request() {
    throw UnimplementedError();
  }

  @override
  T? parse(dynamic body) {
    return null;
  }

  @override
  Future<void> run(Function? completion) async {
    super.run(completion);

    if (this.shouldCancelOperation()) return;

    Response response = await this.request();
    switch (response.statusCode) {
      case OperationStatusCode.ok:
        {
          this.verifyData(response.body);
        }
        break;
      default:
        {
          this.noDataAvailableErrorBlock();
        }
        break;
    }
  }

  bool shouldCancelOperation() {
    if (this.isCancelled) {
      this.cancelledOperationErrorBlock();
      return true;
    }
    return false;
  }

  void verifyData(String? data) {
    if (this.shouldCancelOperation()) return;

    if (data != null) {
      this.decodeData(data);
    } else {
      this.noDataAvailableErrorBlock();
    }
  }

  void decodeData(String data) {
    if (this.shouldCancelOperation()) return;

    try {
      final value = this.parseData(data);
      this.transformData(value);
    } catch (exception) {
      // TODO: - Log error;
      this.cannotParseResponseErrorBlock();
    }
  }

  T? parseData(String data) {
    try {
      dynamic json = jsonDecode(data);
      return this.parse(json);
    } catch (exception) {
      rethrow;
    }
  }

  void transformData(T? response) {
    if (this.shouldCancelOperation()) return;

    if (response != null) {
      this.successfulResultBlock(response);
    } else {
      this.noDataAvailableErrorBlock();
    }
  }

  void cancelledOperationErrorBlock() {
    this.completionHandler?.failure(OperationError.operationCancelled);

    if (this.completion != null) {
      this.completion!();
    }
  }

  void noDataAvailableErrorBlock() {
    this.completionHandler?.failure(OperationError.noDataAvailable);

    if (this.completion != null) {
      this.completion!();
    }
  }

  void cannotParseResponseErrorBlock() {
    this.completionHandler?.failure(OperationError.cannotParseResponse);

    if (this.completion != null) {
      this.completion!();
    }
  }

  void successfulResultBlock(T value) {
    this.completionHandler?.success(value);

    if (this.completion != null) {
      this.completion!();
    }
  }
}
