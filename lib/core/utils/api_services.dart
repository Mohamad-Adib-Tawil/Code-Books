import 'package:code_books/core/errors/failure.dart';
import 'package:code_books/core/errors/retry.dart';
import 'package:code_books/core/utils/app_logger.dart';
import 'package:dio/dio.dart';

class ApiServices {
  final Dio _dio;
  static const String baseUrl = String.fromEnvironment(
    'GOOGLE_BOOKS_BASE_URL',
    defaultValue: 'https://www.googleapis.com/books/v1/',
  );

  ApiServices(Dio dio) : _dio = dio {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      responseType: ResponseType.json,
    );
  }

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    try {
      AppLogger.info('GET $endPoint', name: 'ApiServices');
      var response = await retry(
        () async {
          final response = await _dio.get<Map<String, dynamic>>(endPoint);
          AppLogger.info(
            'GET $endPoint -> ${response.statusCode}',
            name: 'ApiServices',
          );
          return response.data ?? <String, dynamic>{};
        },
        retries: 3,
        delay: const Duration(seconds: 1),
      );

      return response;
    } on DioException catch (e) {
      AppLogger.error(
        'Dio request failed: GET $endPoint',
        error: e,
        stackTrace: e.stackTrace,
        name: 'ApiServices',
      );
      throw ServerFailure.fromDioException(e);
    } catch (e) {
      AppLogger.error(
        'Unexpected request failure: GET $endPoint',
        error: e,
        name: 'ApiServices',
      );
      throw ServerFailure(e.toString());
    }
  }
}
