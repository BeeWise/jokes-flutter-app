import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jokes/localization/LocalizationManager.dart';
import 'package:jokes/managers/context/ContextManager.dart';
import 'package:jokes/scenes/jokes/JokesController.dart';
import 'package:jokes/style/ApplicationStyle.dart';
import 'package:jokes/tasks/configurator/TaskConfigurator.dart';
import 'package:jokes/tasks/environment/TaskEnvironment.dart';

void main() async {
  const envFileName = String.fromEnvironment("ENV_FILE_NAME");
  await dotenv.load(fileName: envFileName);

  shouldSetupEnvironment();
  runApp(const MyApp());
}

void shouldSetupEnvironment() {
  final environment = dotenv.get("ENVIRONMENT", fallback: 'none');
  if (environment != 'none') {
    TaskConfigurator.instance.environment = TaskEnvironment.values.firstWhere((element) => element.name == environment);
  } else {
    TaskConfigurator.instance.environment = TaskEnvironment.memory;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      onGenerateTitle: (BuildContext context) => dotenv.get("APP_NAME"),
      navigatorKey: ContextManager.instance.navigatorKey,
      localizationsDelegates: LocalizationManager.instance.localizationsDelegates(),
      supportedLocales: LocalizationManager.instance.supportedLocales(),
      theme: ThemeData(
        primaryColor: ApplicationStyle.colors.primary,
      ),
      home: const JokesController(),
    );
  }
}