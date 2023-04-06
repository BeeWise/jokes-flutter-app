import 'package:jokes/operations/base/operations/Operation.dart';

class OperationQueue {
  List<Operation> operations = List.empty(growable: true);

  int get operationCount {
    return this.operations.length;
  }

  void addOperation(Operation operation) {
    this.operations.add(operation);

    operation.run(() {
      this.operations.remove(operation);
    });
  }

  void cancelAllOperations() {
    this.operations.forEach((element) {
      element.cancel();
    });
    this.operations.clear();
  }
}
