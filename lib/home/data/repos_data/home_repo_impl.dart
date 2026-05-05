import 'package:code_books/core/errors/failure.dart';
import 'package:code_books/home/data/data_sources/home_local_data_source.dart';
import 'package:code_books/home/data/data_sources/home_remote_data_source.dart';
import 'package:code_books/home/domain/entities/book_entity.dart';
import 'package:code_books/home/domain/repos_domain/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepoImpl(this.homeRemoteDataSource, this.homeLocalDataSource);
  @override
  Future<Either<Failure, List<BookEntity>>> fetchPopularBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'popular',
  }) async {
    List<BookEntity> booksList;
    try {
      booksList = homeLocalDataSource.fetchPopularBooks(
        pageNumber: pageNumber,
        searchName: searchName,
        sord: sord,
      );
      if (booksList.isNotEmpty) {
        return right(booksList);
      }
      booksList = await homeRemoteDataSource.fetchPopularBooks(
        pageNumber: pageNumber,
        searchName: searchName,
        sord: sord,
      );
      return right(booksList);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchNewestBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'new',
  }) async {
    List<BookEntity> booksList;
    try {
      booksList = homeLocalDataSource.fetchNewestBooks(
        pageNumber: pageNumber,
        searchName: searchName,
        sord: sord,
      );
      if (booksList.isNotEmpty) {
        return right(booksList);
      }
      booksList = await homeRemoteDataSource.fetchNewestBooks(
        pageNumber: pageNumber,
        searchName: searchName,
        sord: sord,
      );
      return right(booksList);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchBooksIn({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'newest',
  }) async {
    List<BookEntity> booksList;
    try {
      booksList = homeLocalDataSource.fetchBooksIn(
        pageNumber: pageNumber,
        searchName: searchName,
        sord: sord,
      );
      if (booksList.isNotEmpty) {
        return right(booksList);
      }
      booksList = await homeRemoteDataSource.fetchBooksIn(
        pageNumber: pageNumber,
        searchName: searchName,
        sord: sord,
      );
      return right(booksList);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioException(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
