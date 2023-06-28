import '../../tasks/joke/JokeTask.dart';
import '../../tasks/environment/TaskEnvironment.dart';

class TaskConfigurator {
  TaskConfigurator._privateConstructor();
  static final TaskConfigurator instance =
      TaskConfigurator._privateConstructor();

  TaskEnvironment environment = TaskEnvironment.memory;

  JokeTaskProtocol jokeTask() {
    return JokeTask(this.environment);
  }
}
