import 'package:jokes/localization/LocalizationManager.dart';

class JokesLocalization {
  JokesLocalization._privateConstructor();
  static final JokesLocalization instance = JokesLocalization._privateConstructor();

  jokeOfTheDayTitle() {
    return LocalizationManager.instance.appLocalizations()?.jokesSceneJokeOfTheDayTitle ?? '';
  }

  jokeOfTheWeekTitle() {
    return LocalizationManager.instance.appLocalizations()?.jokesSceneJokeOfTheWeekTitle ?? '';
  }

  jokeOfTheMonthTitle() {
    return LocalizationManager.instance.appLocalizations()?.jokesSceneJokeOfTheMonthTitle ?? '';
  }

  jokeOfTheYearTitle() {
    return LocalizationManager.instance.appLocalizations()?.jokesSceneJokeOfTheYearTitle ?? '';
  }

  noMoreItemsText() {
    return LocalizationManager.instance.appLocalizations()?.jokesSceneNoMoreItemsText ?? '';
  }

  errorText() {
    return LocalizationManager.instance.appLocalizations()?.jokesSceneErrorText ?? '';
  }

  sourceText(source) {
    return LocalizationManager.instance.appLocalizations()?.jokesSceneSourceText(source) ?? '';
  }
}
