import '../../../operations/base/errors/OperationError.dart';
import 'package:uuid/uuid.dart';

class Operation {
  final String id = const Uuid().v4();

  bool isCancelled = false;
  bool isLoggingEnabled = false;

  Function? completion;

  void run(Function? completion) async {
    this.completion = completion;
  }

  void cancel() {
    this.isCancelled = true;
  }

  void log() {
    if (!this.isLoggingEnabled) return;
  }
}

abstract class ResultInterface<T> {
  late final void Function(T) success;
  late final void Function(OperationError) failure;
}

class Result<T> extends ResultInterface<T> {
  final void Function(T) success;
  final void Function(OperationError) failure;

  Result(this.success, this.failure);
}
