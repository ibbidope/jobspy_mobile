import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/models.dart';
import 'api.dart';

class ApiRepository {
  final ApiProvider apiProvider;

  ApiRepository({required this.apiProvider});

  Future<HealthModel?> getHealth() async {
    try {
      final response = await apiProvider.get(ApiConstants.getHealth);

      if (response.statusCode == 200) {
        final data = _parseJson(response.data);
        if (data is Map<String, dynamic>) {
          return HealthModel.fromJson(data);
        }
      }
      return null;
    } on DioException catch (e) {
      _logError(e, 'Health Check Error');
      return null;
    }
  }

  Future<List<JobModel>> getJobs(Map<String, dynamic> payload) async {
    try {
      final response = await apiProvider.post(ApiConstants.getJobs, payload);

      if (response.statusCode == 200) {
        final data = _parseJson(response.data);
        if (data is Map<String, dynamic>) {
          final jobs = (data['jobs'] as List<dynamic>? ?? [])
              .whereType<Map<String, dynamic>>()
              .map(JobModel.fromJson)
              .toList();
          return jobs;
        }
      }
      return [];
    } on DioException catch (e) {
      _logError(e, 'Get Job Error');
      return [];
    }
  }
}

void _logError(DioException e, String fallbackMessage) {
  if (kDebugMode) {
    print(e.response?.data ?? fallbackMessage);
  }
}

dynamic _parseJson(dynamic data) {
  if (data is Map<String, dynamic> || data is List<dynamic>) {
    return data;
  }

  if (data is String) {
    final cleaned = data.replaceAll(
      RegExp(r'\bNaN\b', caseSensitive: false),
      'null',
    );
    return jsonDecode(cleaned);
  }

  return null;
}
