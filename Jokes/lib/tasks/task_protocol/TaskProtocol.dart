import '../../tasks/environment/TaskEnvironment.dart';

abstract class TaskProtocol {
  TaskEnvironment environment;
  TaskProtocol(this.environment);
}
