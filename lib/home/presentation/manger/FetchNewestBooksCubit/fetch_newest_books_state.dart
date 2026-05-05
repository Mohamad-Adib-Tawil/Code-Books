part of 'fetch_newest_books_cubit.dart';

@immutable
sealed class FetchNewestBooksState {}

final class FetchNewestBooksInitial extends FetchNewestBooksState {}

class NewestBooksLoading extends FetchNewestBooksState {}

class NewestBooksPaginationLoading extends FetchNewestBooksState {}

class NewestBooksPaginationFailure extends FetchNewestBooksState {
  final String errMessage;

  NewestBooksPaginationFailure(this.errMessage);
}

class NewestBooksFailure extends FetchNewestBooksState {
  final String errMessage;

  NewestBooksFailure(this.errMessage);
}

class NewestBooksSuccess extends FetchNewestBooksState {
  final List<BookEntity> books;

  NewestBooksSuccess(this.books);
}

class FlutterBooks extends FetchNewestBooksState {
  final List<BookEntity> books;

  FlutterBooks(this.books);
}

class AlgorithmsBooks extends FetchNewestBooksState {
  final List<BookEntity> books;

  AlgorithmsBooks(this.books);
}

class JavaScriptBooks extends FetchNewestBooksState {
  final List<BookEntity> books;

  JavaScriptBooks(this.books);
}

class PythonBooks extends FetchNewestBooksState {
  final List<BookEntity> books;

  PythonBooks(this.books);
}

class PhpBooks extends FetchNewestBooksState {
  final List<BookEntity> books;

  PhpBooks(this.books);
}

class FlutterBooksPaginationLoading extends FetchNewestBooksState {}

class AlgorithmsBooksPaginationLoading extends FetchNewestBooksState {}

class JavaScriptBooksPaginationLoading extends FetchNewestBooksState {}

class PythonBooksPaginationLoading extends FetchNewestBooksState {}

class PhpBooksPaginationLoading extends FetchNewestBooksState {}
