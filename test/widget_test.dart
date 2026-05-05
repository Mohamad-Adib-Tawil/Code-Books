import 'dart:io';

import 'package:code_books/contants.dart';
import 'package:code_books/core/errors/failure.dart';
import 'package:code_books/home/data/data_sources/home_local_data_source.dart';
import 'package:code_books/home/data/data_sources/home_remote_data_source.dart';
import 'package:code_books/home/data/repos_data/home_repo_impl.dart';
import 'package:code_books/home/domain/entities/book_entity.dart';
import 'package:code_books/main.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  late Directory hiveDirectory;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    hiveDirectory = await Directory.systemTemp.createTemp('code_books_test_');
    Hive.init(hiveDirectory.path);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(BookEntityAdapter());
    }
    await Hive.openBox<BookEntity>(kPopularBox);
    await Hive.openBox<BookEntity>(kNewestBox);
    GetIt.instance.registerSingleton<HomeRepoImpl>(_FakeHomeRepoImpl());
  });

  tearDownAll(() async {
    await Hive.close();
    await hiveDirectory.delete(recursive: true);
    await GetIt.instance.reset();
  });

  testWidgets('renders app shell without bootstrap crashes', (tester) async {
    tester.view.physicalSize = const Size(1440, 2960);
    tester.view.devicePixelRatio = 2;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsWidgets);
  });
}

class _FakeHomeRepoImpl extends HomeRepoImpl {
  _FakeHomeRepoImpl() : super(_FakeRemoteDataSource(), _FakeLocalDataSource());

  @override
  Future<Either<Failure, List<BookEntity>>> fetchPopularBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'popular',
  }) async {
    return right(<BookEntity>[]);
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchNewestBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'new',
  }) async {
    return right(<BookEntity>[]);
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchBooksIn({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'newest',
  }) async {
    return right(<BookEntity>[]);
  }
}

class _FakeRemoteDataSource extends HomeRemoteDataSource {
  @override
  Future<List<BookEntity>> fetchPopularBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'popular',
  }) async {
    return <BookEntity>[];
  }

  @override
  Future<List<BookEntity>> fetchNewestBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'new',
  }) async {
    return <BookEntity>[];
  }

  @override
  Future<List<BookEntity>> fetchBooksIn({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'newest',
  }) async {
    return <BookEntity>[];
  }
}

class _FakeLocalDataSource extends HomeLocalDataSource {
  @override
  Future<List<BookEntity>> fetchPopularBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'popular',
  }) async {
    return <BookEntity>[];
  }

  @override
  Future<List<BookEntity>> fetchNewestBooks({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'new',
  }) async {
    return <BookEntity>[];
  }

  @override
  Future<List<BookEntity>> fetchBooksIn({
    int pageNumber = 0,
    String searchName = 'programming',
    String sord = 'newest',
  }) async {
    return <BookEntity>[];
  }
}
