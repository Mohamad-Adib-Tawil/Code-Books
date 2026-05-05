import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
  factory ServerFailure.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
        return ServerFailure('connectionError Error');
      case DioExceptionType.connectionTimeout:
        return ServerFailure('connectionTimeout Error');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('receiveTimeout Error');
      case DioExceptionType.sendTimeout:
        return ServerFailure('sendTimeout Error');
      case DioExceptionType.badResponse:
        return ServerFailure.formResponse(
          e.response?.statusCode ?? 0,
          e.response?.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('requestCancelled Exception');
      case DioExceptionType.badCertificate:
        return ServerFailure('badCertificate Error');
      case DioExceptionType.unknown:
        return ServerFailure(e.message ?? 'unknown Error');
    }
  }
  factory ServerFailure.formResponse(int statusCode, dynamic response) {
    if (statusCode == 500) {
      return ServerFailure('there is problem with server');
    } else if (statusCode == 404) {
      return ServerFailure('your Request was not found');
    } else if (statusCode == 429) {
      return ServerFailure('Rate Limit Exceeded: Too Many Requests');
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(
        'Bad Requset $statusCode your response is:$response ',
      );
    } else {
      return ServerFailure('unknown Error');
    }
  }
}
