import 'package:flutter/foundation.dart';

class AppConfig {
  static const String appName = 'CraftMitra AI';
  static String get apiBaseUrl =>
      kIsWeb || defaultTargetPlatform == TargetPlatform.windows
          ? 'http://127.0.0.1:8000'
          : 'http://10.0.2.2:8000';
}
