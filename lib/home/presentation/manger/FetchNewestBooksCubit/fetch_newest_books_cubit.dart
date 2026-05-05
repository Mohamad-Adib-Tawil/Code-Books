import 'package:code_books/core/errors/failure.dart';
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
          if (pageNumber == 0) {
            emit(NewestBooksFailure(failure.message));
          } else {
            emit(NewestBooksPaginationFailure(failure.message));
          }
          return Left(failure);
        },
        (books) {
          emit(NewestBooksSuccess(books));
          return Right(books);
        },
      );
    } catch (e) {
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
        if (pageNumber == 0) {
          emit(NewestBooksFailure(failure.message));
        } else {
          emit(NewestBooksPaginationFailure(failure.message));
        }
      },
      (books) {
        emitState(books);
      },
    );
  }
}
