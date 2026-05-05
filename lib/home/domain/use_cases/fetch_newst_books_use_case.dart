import 'package:code_books/core/errors/failure.dart';
import 'package:code_books/core/use_cases/use_case.dart';
import 'package:code_books/home/domain/entities/book_entity.dart';
import 'package:code_books/home/domain/repos_domain/home_repo.dart';
import 'package:dartz/dartz.dart';

class FetchNewestBooksUseCase extends UseCase<List<BookEntity>, int> {
  final HomeRepo homeRepo;

  FetchNewestBooksUseCase(this.homeRepo);
  @override
  Future<Either<Failure, List<BookEntity>>> call([
    int param = 0,
    String searchName = 'programming',
    String sord = 'new',
  ]) async {
    return await homeRepo.fetchNewestBooks(
      pageNumber: param,
      searchName: searchName,
      sord: sord,
    );
  }
}
