import 'package:code_books/core/utils/functions/build_error_snack_bar.dart';
import 'package:code_books/core/utils/app_logger.dart';
import 'package:code_books/home/domain/entities/book_entity.dart';
import 'package:code_books/home/presentation/manger/popular_books_cubit/cubit/popular_books_cubit_cubit.dart';
import 'package:code_books/home/presentation/views/widgets/book_stack_list_view.dart';
import 'package:code_books/home/presentation/views/widgets/book_stack_pagimation_list_view.dart';
import 'package:code_books/contants.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookStackListBlocConsumer extends StatefulWidget {
  const BookStackListBlocConsumer({super.key});

  @override
  State<BookStackListBlocConsumer> createState() =>
      _BookStackListBlocConsumerState();
}

class _BookStackListBlocConsumerState extends State<BookStackListBlocConsumer> {
  List<BookEntity> books = [];
  List<BookEntity> booksTrend = [];
  List<BookEntity> booksNewest = [];
  bool _isFirstPageRefresh = false;

  @override
  void initState() {
    super.initState();
    // Prefill UI from cache immediately when returning to HomeView
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _loadCachedLists();
    });
  }

  Future<void> _loadCachedLists() async {
    try {
      final popularBoxName = boxNameFor('popular', 'programming');
      final newestBoxName = boxNameFor('new', 'programming');
      final trendBoxName = boxNameFor('relevance', 'programming');

      final popularBox = Hive.isBoxOpen(popularBoxName)
          ? Hive.box<BookEntity>(popularBoxName)
          : await Hive.openBox<BookEntity>(popularBoxName);
      final newestBox = Hive.isBoxOpen(newestBoxName)
          ? Hive.box<BookEntity>(newestBoxName)
          : await Hive.openBox<BookEntity>(newestBoxName);
      final trendBox = Hive.isBoxOpen(trendBoxName)
          ? Hive.box<BookEntity>(trendBoxName)
          : await Hive.openBox<BookEntity>(trendBoxName);

      if (mounted) {
        AppLogger.info(
          'Loaded cached stack lists popular=${popularBox.length} newest=${newestBox.length} trend=${trendBox.length}',
          name: 'BookStackListBlocConsumer',
        );
        setState(() {
          books = popularBox.values.toList();
          booksNewest = newestBox.values.toList();
          booksTrend = trendBox.values.toList();
        });
      }
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to load cached stack lists',
        error: e,
        stackTrace: stackTrace,
        name: 'BookStackListBlocConsumer',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PopularBooksCubit, PopularBooksCubitState>(
      bloc: context.read<PopularBooksCubit>(),
      listener: (context, state) {
        if (state is PopularBooksLoading) {
          _isFirstPageRefresh = true;
          AppLogger.info(
            'Popular stack loading, keeping current lists',
            name: 'BookStackListBlocConsumer',
          );
        } else if (state is PopularBooksPaginationLoading) {
          _isFirstPageRefresh = false;
        } else if (state is PopularBooksSuccess) {
          if (mounted) {
            setState(() {
              if (_isFirstPageRefresh) {
                books = List<BookEntity>.of(state.books);
              } else {
                books.addAll(state.books);
              }
              _isFirstPageRefresh = false;
            });
          }
        } else if (state is PopularBooksNewest) {
          if (mounted) {
            setState(() {
              if (_isFirstPageRefresh) {
                booksNewest = List<BookEntity>.of(state.books);
              } else {
                booksNewest.addAll(state.books);
              }
              _isFirstPageRefresh = false;
            });
          }
        } else if (state is PopularBooksTrend) {
          if (mounted) {
            setState(() {
              if (_isFirstPageRefresh) {
                booksTrend = List<BookEntity>.of(state.books);
              } else {
                booksTrend.addAll(state.books);
              }
              _isFirstPageRefresh = false;
            });
          }
        } else if (state is PopularBooksPaginationFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(buildErrorWidget(state.errMessage));
        } else if (state is PopularBooksFailure) {
          AppLogger.error(
            'Popular stack refresh failed: ${state.errMessage}',
            name: 'BookStackListBlocConsumer',
          );
          if (books.isNotEmpty ||
              booksNewest.isNotEmpty ||
              booksTrend.isNotEmpty) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(buildErrorWidget(state.errMessage));
          }
        }
      },
      builder: (context, state) {
        Widget child;
        String visualKey = 'popular';

        if (state is PopularBooksLoading) {
          if (books.isNotEmpty) {
            child = BookStackListView(books: books);
            visualKey = 'popular';
          } else {
            child = const BookStackPAginationListView();
            visualKey = 'loading';
          }
        } else if (state is PopularBooksPaginationLoading) {
          // Keep showing accumulated list while next page loads
          child = BookStackListView(books: books);
          visualKey = 'popular';
        } else if (state is PopularBooksSuccess) {
          child = BookStackListView(books: books);
          visualKey = 'popular';
        } else if (state is PopularBooksNewest) {
          child = BookStackListView(books: booksNewest);
          visualKey = 'new';
        } else if (state is PopularBooksTrend) {
          child = BookStackListView(books: booksTrend);
          visualKey = 'trend';
        } else if (state is PopularBooksFailure) {
          if (books.isNotEmpty) {
            child = BookStackListView(books: books);
            visualKey = 'popular';
          } else if (booksNewest.isNotEmpty) {
            child = BookStackListView(books: booksNewest);
            visualKey = 'new';
          } else if (booksTrend.isNotEmpty) {
            child = BookStackListView(books: booksTrend);
            visualKey = 'trend';
          } else {
            child = Center(child: Text(state.errMessage));
            visualKey = 'error';
          }
        } else {
          child = const SizedBox.shrink();
          visualKey = 'empty';
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 240),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (widget, animation) {
            final slide = Tween<Offset>(
              begin: const Offset(0.0, 0.05),
              end: Offset.zero,
            ).animate(animation);
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(position: slide, child: widget),
            );
          },
          child: KeyedSubtree(key: ValueKey(visualKey), child: child),
        );
      },
    );
  }
}
