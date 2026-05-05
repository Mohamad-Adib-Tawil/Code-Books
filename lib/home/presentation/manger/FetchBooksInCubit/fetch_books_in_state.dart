part of 'fetch_books_in_cubit.dart';

@immutable
sealed class FetchBooksInState {}

final class FetchBooksInInitial extends FetchBooksInState {}

final class FetchBooksInCubitInitial extends FetchBooksInState {}

class FetchBooksInLoading extends FetchBooksInState {}

class FetchBooksInPaginationLoading extends FetchBooksInState {}

class FetchBooksInPaginationFailure extends FetchBooksInState {
  final String errMessage;

  FetchBooksInPaginationFailure(this.errMessage);
}

class FetchBooksInFailure extends FetchBooksInState {
  final String errMessage;

  FetchBooksInFailure(this.errMessage);
}

class FetchBooksInSuccess extends FetchBooksInState {
  final List<BookEntity> books;

  FetchBooksInSuccess(this.books);
}
