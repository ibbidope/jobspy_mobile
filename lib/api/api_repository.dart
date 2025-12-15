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

      return response.statusCode == 200
          ? HealthModel.fromJson(response.data)
          : null;
    } on DioException catch (e) {
      _logError(e, 'Health Check Error');
      return null;
    }
  }

  Future<bool> getJobs(JobModel data) async {
    try {
      final response = await apiProvider.post(
        ApiConstants.getJobs,
        data.toJson(),
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      _logError(e, 'Get Job Error');
      return false;
    }
  }
}

void _logError(DioException e, String fallbackMessage) {
  if (kDebugMode) {
    print(e.response?.data ?? fallbackMessage);
  }
}
