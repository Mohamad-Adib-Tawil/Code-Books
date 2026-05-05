import 'package:code_books/contants.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/book_entity.dart';

abstract class HomeLocalDataSource {
  List<BookEntity> fetchPopularBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'popular',
  });
  List<BookEntity> fetchNewestBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'new',
  });
  List<BookEntity> fetchBooksIn({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'newest',
  });
}

///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  List<BookEntity> fetchPopularBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'popular',
  }) {
    final boxName = boxNameFor(sord, searchName);
    if (!Hive.isBoxOpen(boxName)) {
      return [];
    }
    var box = Hive.box<BookEntity>(boxName);
    int length = box.values.length;
    int startIndex = pageNumber * 10;
    int endIndex = (pageNumber + 1) * 10;

    if (startIndex >= length || endIndex > length) {
      return [];
    }
    return box.values.toList().sublist(startIndex, endIndex);
  }

  @override
  List<BookEntity> fetchNewestBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'new',
  }) {
    final boxName = boxNameFor(sord, searchName);
    if (!Hive.isBoxOpen(boxName)) {
      return [];
    }
    var box = Hive.box<BookEntity>(boxName);
    int length = box.values.length;
    int startIndex = pageNumber * 10;
    int endIndex = (pageNumber + 1) * 10;

    if (startIndex >= length || endIndex > length) {
      return [];
    }
    return box.values.toList().sublist(startIndex, endIndex);
  }

  @override
  List<BookEntity> fetchBooksIn({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'newest',
  }) {
    final boxName = boxNameFor(sord, searchName);
    if (!Hive.isBoxOpen(boxName)) {
      return [];
    }
    var box = Hive.box<BookEntity>(boxName);
    int length = box.values.length;
    int startIndex = pageNumber * 10;
    int endIndex = (pageNumber + 1) * 10;

    if (startIndex >= length || endIndex > length) {
      return [];
    }
    return box.values.toList().sublist(startIndex, endIndex);
  }
}
