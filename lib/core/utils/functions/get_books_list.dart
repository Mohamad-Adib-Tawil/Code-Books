import 'package:code_books/home/data/models/book_model/book_model.dart';

import '../../../home/domain/entities/book_entity.dart';

List<BookEntity> getBooksList(Map<String, dynamic> data) {
  final items = data['items'];
  if (items is! List) {
    // API may return no 'items' when there are no results
    return <BookEntity>[];
  }
  final List<BookEntity> books = [];
  for (final bookMap in items) {
    try {
      if (bookMap is Map<String, dynamic>) {
        books.add(BookModel.fromJson(bookMap));
      }
    } catch (_) {
      // skip malformed entries
    }
  }
  return books;
}
