import 'package:flutter/material.dart';

class ContextManager {
  ContextManager._privateConstructor();
  static final ContextManager instance = ContextManager._privateConstructor();

  final navigatorKey = GlobalKey<NavigatorState>();

  BuildContext? context() {
    return this.navigatorKey.currentContext;
  }
}
