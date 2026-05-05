import 'package:dartz/dartz.dart';

import 'package:code_books/core/errors/failure.dart';

import '../../../core/use_cases/use_case.dart';
import '../entities/book_entity.dart';
import '../repos_domain/home_repo.dart';

class FetchPopualrBooksUseCase extends UseCase<List<BookEntity>, int> {
  final HomeRepo homeRepo;

  FetchPopualrBooksUseCase(this.homeRepo);
  @override
  Future<Either<Failure, List<BookEntity>>> call([
    int param = 0,
    String searchName = 'programming',
    String sord = 'popular',
  ]) async {
    return await homeRepo.fetchPopularBooks(
      pageNumber: param,
      searchName: searchName,
      sord: sord,
    );
  }
}
