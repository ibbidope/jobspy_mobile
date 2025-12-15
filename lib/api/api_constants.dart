import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static final String baseUrl = _readRequiredEnv('API_BASE_URL');

  static const String getHealth = "/health";
  static const String getJobs = "/scrape";

  static String _readRequiredEnv(String key) {
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      throw StateError('Environment variable $key is missing or empty');
    }
    return value;
  }
}
