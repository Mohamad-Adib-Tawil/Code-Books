import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../entities/book_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BookEntity>>> fetchPopularBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'popular',
  });
  Future<Either<Failure, List<BookEntity>>> fetchNewestBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'new',
  });
  Future<Either<Failure, List<BookEntity>>> fetchBooksIn({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'newest',
  });
  // Future<Either<Failure, List<BookEntity>>> fetchTrendBooks();
  // Future<Either<Failure, List<BookEntity>>> fetchFavoritesBooks(
  //     String bookId, String userId);
  // Future<Either<Failure, List<BookEntity>>> fetchResumeReadingBooks(
  //     String userId);
  // Future<Either<Failure, List<BookEntity>>> fetchLikeBook(
  //     [List<String>? categories]);
}
