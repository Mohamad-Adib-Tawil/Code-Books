// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../core/utils/api_services.dart';
import '../../../core/utils/functions/get_books_list.dart';
import '../../../core/utils/functions/save_book.dart';
import '../../../contants.dart';
import '../../domain/entities/book_entity.dart';

abstract class HomeRemoteDataSource {
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

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiServices apiServices;
  HomeRemoteDataSourceImpl({required this.apiServices});

  String _orderByFor(String sord) {
    final s = sord.toLowerCase().trim();
    if (s == 'new' || s == 'newest') return 'newest';
    // treat everything else (popular/trend/relevance) as relevance
    return 'relevance';
  }

  String _queryFor(String sord, String searchName) {
    final s = sord.toLowerCase().trim();
    final q = searchName.trim().isEmpty ? 'programming' : searchName.trim();
    if (s == 'trend' || s == 'trending' || s == 'relevance') {
      // Nudge results toward trending/tech by adding subject hints
      // This makes trend differ from popular while keeping user's base query
      return '$q+subject:technology+subject:computers';
    }
    // popular/new use the base query
    return q;
  }

  @override
  Future<List<BookEntity>> fetchPopularBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'popular',
  }) async {
    final orderBy = _orderByFor(sord);
    final q = _queryFor(sord, searchName);
    var data = await apiServices.get(
      endPoint:
          'volumes?filter=free-ebooks&orderBy=$orderBy&maxResults=20&q=$q&startIndex=${pageNumber * 20}',
    );
    List<BookEntity> books = getBooksList(data);
    // persist per category/list cache
    await saveBooksPageAsync(
      books,
      boxNameFor(sord, searchName),
      pageNumber: pageNumber,
    );
    return books;
  }

  @override
  Future<List<BookEntity>> fetchNewestBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'new',
  }) async {
    final orderBy = _orderByFor(sord);
    final q = _queryFor(sord, searchName);
    var data = await apiServices.get(
      endPoint:
          'volumes?filter=free-ebooks&orderBy=$orderBy&maxResults=20&q=$q&startIndex=${pageNumber * 20}',
    );
    List<BookEntity> books = getBooksList(data);
    // Fallback: if no items, retry without the free-ebooks filter to broaden results
    if (books.isEmpty) {
      data = await apiServices.get(
        endPoint:
            'volumes?orderBy=$orderBy&maxResults=20&q=$q&startIndex=${pageNumber * 20}',
      );
      books = getBooksList(data);
    }
    await saveBooksPageAsync(
      books,
      boxNameFor(sord, searchName),
      pageNumber: pageNumber,
    );
    return books;
  }

  @override
  Future<List<BookEntity>> fetchBooksIn({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'newest',
  }) async {
    final orderBy = _orderByFor(sord);
    final q = _queryFor(sord, searchName);
    var data = await apiServices.get(
      endPoint:
          'volumes?filter=free-ebooks&orderBy=$orderBy&q=$q&startIndex=${pageNumber * 10}',
    );
    List<BookEntity> books = getBooksList(data);
    await saveBooksPageAsync(
      books,
      boxNameFor(sord, searchName),
      pageNumber: pageNumber,
    );
    return books;
  }
}
