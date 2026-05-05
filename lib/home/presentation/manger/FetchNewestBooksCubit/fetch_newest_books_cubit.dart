import 'package:code_books/core/errors/failure.dart';
import 'package:code_books/core/utils/app_logger.dart';
import 'package:code_books/home/domain/entities/book_entity.dart';
import 'package:code_books/home/domain/use_cases/fetch_newst_books_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'fetch_newest_books_state.dart';

class FetchNewestBooksCubit extends Cubit<FetchNewestBooksState> {
  FetchNewestBooksCubit(this.fetchNewestBooksUseCase)
    : super(FetchNewestBooksInitial());

  final FetchNewestBooksUseCase fetchNewestBooksUseCase;

  Future<Either<Failure, List<BookEntity>>> fetchNewestBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'new',
  }) async {
    AppLogger.info(
      'fetchNewest page=$pageNumber search=$searchName sort=$sord',
      name: 'FetchNewestBooksCubit',
    );
    if (pageNumber == 0) {
      emit(NewestBooksLoading());
    } else {
      emit(NewestBooksPaginationLoading());
    }

    try {
      final result = await fetchNewestBooksUseCase.call(
        pageNumber,
        searchName,
        sord,
      );

      return result.fold(
        (failure) {
          AppLogger.error(
            'fetchNewest failed page=$pageNumber',
            error: failure,
            name: 'FetchNewestBooksCubit',
          );
          if (pageNumber == 0) {
            emit(NewestBooksFailure(failure.message));
          } else {
            emit(NewestBooksPaginationFailure(failure.message));
          }
          return Left(failure);
        },
        (books) {
          AppLogger.info(
            'fetchNewest success count=${books.length}',
            name: 'FetchNewestBooksCubit',
          );
          emit(NewestBooksSuccess(books));
          return Right(books);
        },
      );
    } catch (e) {
      AppLogger.error(
        'fetchNewest unexpected failure',
        error: e,
        name: 'FetchNewestBooksCubit',
      );
      emit(NewestBooksFailure('An unexpected error occurred: ${e.toString()}'));
      return Left(
        ServerFailure('An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  Future<void> toggleToFlutter({
    int pageNumber = 0,
    String searchName = 'flutter',
    String sord = 'new',
  }) async {
    AppLogger.info(
      'toggleToFlutter page=$pageNumber search=$searchName sort=$sord',
      name: 'FetchNewestBooksCubit',
    );
    await _fetchBooks(
      pageNumber: pageNumber,
      searchName: searchName,
      sord: sord,
      loadingState: FlutterBooksPaginationLoading(),
      emitState: (books) => emit(FlutterBooks(books)),
    );
  }

  Future<void> toggleToAlgorithms({
    int pageNumber = 0,
    String searchName = 'Algorithms',
    String sord = 'new',
  }) async {
    AppLogger.info(
      'toggleToAlgorithms page=$pageNumber search=$searchName sort=$sord',
      name: 'FetchNewestBooksCubit',
    );
    await _fetchBooks(
      pageNumber: pageNumber,
      searchName: searchName,
      sord: sord,
      loadingState: AlgorithmsBooksPaginationLoading(),
      emitState: (books) => emit(AlgorithmsBooks(books)),
    );
  }

  Future<void> toggleToJavaScript({
    int pageNumber = 0,
    String searchName = 'java script',
    String sord = 'new',
  }) async {
    AppLogger.info(
      'toggleToJavaScript page=$pageNumber search=$searchName sort=$sord',
      name: 'FetchNewestBooksCubit',
    );
    await _fetchBooks(
      pageNumber: pageNumber,
      searchName: searchName,
      sord: sord,
      loadingState: JavaScriptBooksPaginationLoading(),
      emitState: (books) => emit(JavaScriptBooks(books)),
    );
  }

  Future<void> toggleToPython({
    int pageNumber = 0,
    String searchName = 'python',
    String sord = 'new',
  }) async {
    AppLogger.info(
      'toggleToPython page=$pageNumber search=$searchName sort=$sord',
      name: 'FetchNewestBooksCubit',
    );
    await _fetchBooks(
      pageNumber: pageNumber,
      searchName: searchName,
      sord: sord,
      loadingState: PythonBooksPaginationLoading(),
      emitState: (books) => emit(PythonBooks(books)),
    );
  }

  Future<void> toggleToPhp({
    int pageNumber = 0,
    String searchName = 'php',
    String sord = 'new',
  }) async {
    AppLogger.info(
      'toggleToPhp page=$pageNumber search=$searchName sort=$sord',
      name: 'FetchNewestBooksCubit',
    );
    await _fetchBooks(
      pageNumber: pageNumber,
      searchName: searchName,
      sord: sord,
      loadingState: PhpBooksPaginationLoading(),
      emitState: (books) => emit(PhpBooks(books)),
    );
  }

  Future<void> _fetchBooks({
    required int pageNumber,
    required String searchName,
    required String sord,
    required FetchNewestBooksState loadingState,
    required Function(List<BookEntity>) emitState,
  }) async {
    if (pageNumber == 0) {
      emit(NewestBooksLoading());
    } else {
      emit(loadingState);
    }

    var result = await fetchNewestBooksUseCase.call(
      pageNumber,
      searchName,
      sord,
    );

    result.fold(
      (failure) {
        AppLogger.error(
          '_fetchBooks failed page=$pageNumber search=$searchName',
          error: failure,
          name: 'FetchNewestBooksCubit',
        );
        if (pageNumber == 0) {
          emit(NewestBooksFailure(failure.message));
        } else {
          emit(NewestBooksPaginationFailure(failure.message));
        }
      },
      (books) {
        AppLogger.info(
          '_fetchBooks success search=$searchName count=${books.length}',
          name: 'FetchNewestBooksCubit',
        );
        emitState(books);
      },
    );
  }
}
