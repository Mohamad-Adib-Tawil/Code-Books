import 'package:code_books/home/domain/entities/book_entity.dart';
import 'package:code_books/home/domain/use_cases/fetch_newst_books_use_case.dart';
import 'package:code_books/home/domain/use_cases/fetch_popular_books_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_books_cubit_state.dart';

class PopularBooksCubit extends Cubit<PopularBooksCubitState> {
  PopularBooksCubit(this.fetchPopualrBooksUseCase, this.fetchNewestBooksUseCase)
    : super(PopularBooksCubitInitial());

  final FetchPopualrBooksUseCase fetchPopualrBooksUseCase;
  final FetchNewestBooksUseCase fetchNewestBooksUseCase;
  Future<void> fetchPopualrBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'popular',
  }) async {
    if (pageNumber == 0) {
      emit(PopularBooksLoading());
    } else {
      emit(PopularBooksPaginationLoading());
    }

    var result = await fetchPopualrBooksUseCase.call(
      pageNumber,
      searchName,
      sord,
    );

    result.fold(
      (l) {
        if (pageNumber == 0) {
          emit(PopularBooksFailure(l.toString()));
        } else {
          emit(PopularBooksPaginationFailure(l.toString()));
        }
      },
      (r) {
        emit(PopularBooksSuccess(r));
      },
    );
  }

  Future<void> fetchPopualrBooksOtherBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'popular',
  }) async {
    if (pageNumber == 0) {
      emit(PopularBooksLoading());
    } else {
      emit(PopularBooksPaginationLoading());
    }

    var result = await fetchPopualrBooksUseCase.call(
      pageNumber,
      searchName,
      sord,
    );

    result.fold(
      (l) {
        if (pageNumber == 0) {
          emit(PopularBooksFailure(l.toString()));
        } else {
          emit(PopularBooksPaginationFailure(l.toString()));
        }
      },
      (r) {
        emit(PopularBooksSuccessOtherBook(r));
      },
    );
  }

  void toggleToTrend({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'relevance',
  }) async {
    if (pageNumber == 0) {
      emit(PopularBooksLoading());
    } else {
      emit(PopularBooksPaginationLoading());
    }
    var result = await fetchPopualrBooksUseCase.call(
      pageNumber,
      searchName,
      sord,
    );
    result.fold(
      (l) {
        if (pageNumber == 0) {
          emit(PopularBooksFailure(l.toString()));
        } else {
          emit(PopularBooksPaginationFailure(l.toString()));
        }
      },
      (r) {
        emit(PopularBooksTrend(r));
      },
    );
  }

  void toggleToNewest({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'newest',
  }) async {
    if (pageNumber == 0) {
      emit(PopularBooksLoading());
    } else {
      emit(PopularBooksPaginationLoading());
    }
    var result = await fetchNewestBooksUseCase.call(
      pageNumber,
      searchName,
      'new',
    );
    result.fold(
      (l) {
        if (pageNumber == 0) {
          emit(PopularBooksFailure(l.toString()));
        } else {
          emit(PopularBooksPaginationFailure(l.toString()));
        }
      },
      (r) {
        emit(PopularBooksNewest(r));
      },
    );
  }
}
