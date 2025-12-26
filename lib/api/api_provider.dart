import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_constants.dart';

class ApiProvider {
  final Dio _dio;

  ApiProvider()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 40),
          responseType: ResponseType.plain,
          headers: {'X-API-Key': dotenv.env['JOBSPY_API_KEY']},
        ),
      ) {
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
          enabled: kDebugMode,
          // filter: (options, args) {
          //   // don't print requests with uris containing '/posts'
          //   if (options.path.contains('/posts')) {
          //     return false;
          //   }
          //   // don't print responses with unit8 list data
          //   return !args.isResponse || !args.hasUint8ListData;
          // },
        ),
      );
    }
  }

  Future<Response> post(String path, dynamic data) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Response> get(String path) async {
    try {
      return await _dio.get(path);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(DioException e) {
    if (kDebugMode) {
      if (e.response != null) {
        print('Dio error response: ${e.response?.data}');
      } else {
        print('Dio error: ${e.message}');
      }
    }
  }
}
