import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String? _baseUrlOverride;

  static String get baseUrl =>
      _baseUrlOverride ?? _readRequiredEnv('API_BASE_URL');

  static const String getHealth = "/health";
  static const String getJobs = "/scrape";

  /// For tests only. Allows overriding the API base URL without dotenv.
  static void setBaseUrlForTesting(String? value) {
    _baseUrlOverride = value;
  }

  static String _readRequiredEnv(String key) {
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      throw StateError('Environment variable $key is missing or empty');
    }
    return value;
  }
}
