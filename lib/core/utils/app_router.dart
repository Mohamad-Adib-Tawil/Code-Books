import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:code_books/home/domain/entities/book_entity.dart';
import 'package:go_router/go_router.dart';

import '../../home/presentation/views/book_details_view.dart';
import '../../home/presentation/views/home_view.dart';
import '../../home/presentation/views/search_view.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kBookDetailsView = '/bookDetailsView';
  static const kLoading = 'kLoading';
  static const kSearchView = '/searchView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeView()),
      GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
      GoRoute(
        path: kBookDetailsView,
        pageBuilder: (context, state) {
          final extra = state.extra;
          if (extra is! BookEntity) {
            return const CupertinoPage(
              child: Scaffold(
                body: Center(child: Text('Book details are unavailable.')),
              ),
            );
          }
          return CupertinoPage(
            key: state.pageKey,
            child: BoookDetailsView(book: extra),
          );
        },
      ),
      GoRoute(
        path: kSearchView,
        pageBuilder: (context, state) {
          return const CupertinoPage(child: SearchView());
        },
      ),
    ],
  );
}
