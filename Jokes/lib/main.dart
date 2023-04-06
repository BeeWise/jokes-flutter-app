import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jokes/scenes/jokes/JokesController.dart';
import 'package:jokes/style/ApplicationStyle.dart';
import 'package:jokes/tasks/configurator/TaskConfigurator.dart';
import 'package:jokes/tasks/environment/TaskEnvironment.dart';

void main() async {
  const envFileName = String.fromEnvironment("ENV_FILE_NAME");
  await dotenv.load(fileName: envFileName);

  final environment = dotenv.get("ENVIRONMENT");
  TaskConfigurator.instance.environment = TaskEnvironment.values
      .firstWhere((element) => element.name == environment);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => 'Jokes',
      theme: ThemeData(
        primaryColor: ApplicationStyle.colors.primary,
      ),
      home: const JokesController(),
    );
  }
}