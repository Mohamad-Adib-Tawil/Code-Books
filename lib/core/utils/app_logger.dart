import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class AppLogger {
  const AppLogger._();

  static void info(String message, {String name = 'CodeBooks'}) {
    if (kDebugMode) {
      developer.log(message, name: name);
    }
  }

  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String name = 'CodeBooks',
  }) {
    if (kDebugMode) {
      developer.log(message, name: name, error: error, stackTrace: stackTrace);
    }
  }
}
