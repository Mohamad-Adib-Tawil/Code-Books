import 'package:code_books/contants.dart';
import 'package:code_books/core/utils/app_logger.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/book_entity.dart';

abstract class HomeLocalDataSource {
  Future<List<BookEntity>> fetchPopularBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'popular',
  });
  Future<List<BookEntity>> fetchNewestBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'new',
  });
  Future<List<BookEntity>> fetchBooksIn({
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
  Future<List<BookEntity>> fetchPopularBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'popular',
  }) async {
    return _fetchBooksPage(
      pageNumber: pageNumber,
      searchName: searchName,
      sord: sord,
    );
  }

  @override
  Future<List<BookEntity>> fetchNewestBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'new',
  }) async {
    return _fetchBooksPage(
      pageNumber: pageNumber,
      searchName: searchName,
      sord: sord,
    );
  }

  @override
  Future<List<BookEntity>> fetchBooksIn({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'newest',
  }) async {
    return _fetchBooksPage(
      pageNumber: pageNumber,
      searchName: searchName,
      sord: sord,
    );
  }

  Future<List<BookEntity>> _fetchBooksPage({
    required int pageNumber,
    required String searchName,
    required String sord,
  }) async {
    final boxName = boxNameFor(sord, searchName);
    final box = Hive.isBoxOpen(boxName)
        ? Hive.box<BookEntity>(boxName)
        : await Hive.openBox<BookEntity>(boxName);
    final length = box.values.length;
    final startIndex = pageNumber * 10;
    final endIndex = (pageNumber + 1) * 10;

    if (startIndex >= length) {
      AppLogger.info(
        'Cache miss box=$boxName page=$pageNumber length=$length',
        name: 'HomeLocalDataSource',
      );
      return [];
    }

    final books = box.values.toList().sublist(
      startIndex,
      endIndex > length ? length : endIndex,
    );
    AppLogger.info(
      'Cache hit box=$boxName page=$pageNumber count=${books.length}',
      name: 'HomeLocalDataSource',
    );
    return books;
  }
}
