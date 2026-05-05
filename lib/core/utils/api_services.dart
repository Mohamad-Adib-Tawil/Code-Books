import 'package:code_books/core/errors/failure.dart';
import 'package:code_books/core/errors/retry.dart';
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
      var response = await retry(
        () async {
          final response = await _dio.get<Map<String, dynamic>>(endPoint);
          return response.data ?? <String, dynamic>{};
        },
        retries: 3,
        delay: const Duration(seconds: 1),
      );

      return response;
    } on DioException catch (e) {
      throw ServerFailure.fromDioException(e);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
