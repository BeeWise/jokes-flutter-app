import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../managers/context/ContextManager.dart';

class LocalizationManager {
  LocalizationManager._privateConstructor();
  static final LocalizationManager instance = LocalizationManager._privateConstructor();

  List<Locale> supportedLocales() {
    return AppLocalizations.supportedLocales;
  }

  List<LocalizationsDelegate> localizationsDelegates() {
    return AppLocalizations.localizationsDelegates;
  }

  AppLocalizations? appLocalizations() {
    final context = ContextManager.instance.context();
    if (context == null) {
      return null;
    }
    return AppLocalizations.of(context);
  }

  String? currentLocale() {
    return this.appLocalizations()?.localeName;
  }
}
