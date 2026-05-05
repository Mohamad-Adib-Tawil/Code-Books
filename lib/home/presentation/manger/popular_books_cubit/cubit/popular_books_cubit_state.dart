part of 'popular_books_cubit_cubit.dart';

@immutable
sealed class PopularBooksCubitState {}

final class PopularBooksCubitInitial extends PopularBooksCubitState {}

class PopularBooksLoading extends PopularBooksCubitState {}

class PopularBooksPaginationLoading extends PopularBooksCubitState {}

class PopularBooksTrend extends PopularBooksCubitState {
  final List<BookEntity> books;

  PopularBooksTrend(this.books);
}

class PopularBooksNewest extends PopularBooksCubitState {
  final List<BookEntity> books;

  PopularBooksNewest(this.books);
}

class PopularBooksPaginationFailure extends PopularBooksCubitState {
  final String errMessage;

  PopularBooksPaginationFailure(this.errMessage);
}

class PopularBooksFailure extends PopularBooksCubitState {
  final String errMessage;

  PopularBooksFailure(this.errMessage);
}

class PopularBooksSuccess extends PopularBooksCubitState {
  final List<BookEntity> books;

  PopularBooksSuccess(this.books);
}

class PopularBooksSuccessOtherBook extends PopularBooksCubitState {
  final List<BookEntity> books;

  PopularBooksSuccessOtherBook(this.books);
}
