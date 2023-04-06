import 'package:jokes/localization/LocalizationManager.dart';

class ApplicationLocalization {
  ApplicationLocalization._privateConstructor();
  static final ApplicationLocalization instance = ApplicationLocalization._privateConstructor();

  String cancelTitle() {
    return LocalizationManager.instance.appLocalizations()?.cancelTitle ?? '';
  }

  saveTitle() {
    return LocalizationManager.instance.appLocalizations()?.saveTitle ?? '';
  }

  doneTitle() {
    return LocalizationManager.instance.appLocalizations()?.doneTitle ?? '';
  }

  okTitle() {
    return LocalizationManager.instance.appLocalizations()?.okTitle ?? '';
  }

  jokesTitle() {
    return LocalizationManager.instance.appLocalizations()?.jokesTitle ?? '';
  }

  jokeStatusPendingTitle() {
    return LocalizationManager.instance.appLocalizations()?.jokeStatusPendingTitle ?? '';
  }

  jokeStatusApprovedTitle() {
    return LocalizationManager.instance.appLocalizations()?.jokeStatusApprovedTitle ?? '';
  }

  jokeStatusRejectedTitle() {
    return LocalizationManager.instance.appLocalizations()?.jokeStatusRejectedTitle ?? '';
  }

  jokeStatusAdminRemovedTitle() {
    return LocalizationManager.instance.appLocalizations()?.jokeStatusAdminRemovedTitle ?? '';
  }

  jokeStatusOwnerRemovedTitle() {
    return LocalizationManager.instance.appLocalizations()?.jokeStatusOwnerRemovedTitle ?? '';
  }

  usernameTitle(username) {
    return LocalizationManager.instance.appLocalizations()?.usernameTitle(username) ?? '';
  }

  shareJokeTitle() {
    return LocalizationManager.instance.appLocalizations()?.shareJokeTitle ?? '';
  }

  shareJokeMessage() {
    return LocalizationManager.instance.appLocalizations()?.shareJokeMessage ?? '';
  }

  readAnswerTitle() {
    return LocalizationManager.instance.appLocalizations()?.readAnswerTitle ?? '';
  }

  iOSTitle() {
    return LocalizationManager.instance.appLocalizations()?.iOSTitle ?? '';
  }

  androidTitle() {
    return LocalizationManager.instance.appLocalizations()?.androidTitle ?? '';
  }

  jokeTypeTextTitle() {
    return LocalizationManager.instance.appLocalizations()?.jokeTypeTextTitle ?? '';
  }

  jokeTypeQnaTitle() {
    return LocalizationManager.instance.appLocalizations()?.jokeTypeQnaTitle ?? '';
  }
}
