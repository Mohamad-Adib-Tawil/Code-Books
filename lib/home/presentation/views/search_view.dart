import 'dart:async';

import 'package:code_books/core/utils/app_router.dart';
import 'package:code_books/home/presentation/manger/FetchNewestBooksCubit/fetch_newest_books_cubit.dart';
import 'package:code_books/home/presentation/views/widgets/book_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../contants.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  String _sort = 'new'; // 'new' or 'popular'/'relevance'
  String _subject = 'All'; // 'All' or a specific subject
  // Additional filters
  RangeValues _pageRange = const RangeValues(0, 1500); // pages
  double _minRating = 0; // 0..5

  // Local results with filtering and pagination
  final List<dynamic> _results = [];
  int _nextPage = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // If navigated with ?openFilters=1, open filters after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final params = GoRouterState.of(context).uri.queryParameters;
      if (params['openFilters'] == '1') {
        _openFilters();
      }
    });
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      _search(value.trim(), reset: true);
    });
  }

  void _search(String raw, {bool reset = false}) {
    final base = raw.isEmpty ? 'programming' : raw;
    final subjectPart = _subject != 'All'
        ? '+subject:${_subject.toLowerCase()}'
        : '';
    final query = '$base$subjectPart';
    if (reset) {
      setState(() {
        _results.clear();
        _nextPage = 1;
      });
    }
    context.read<FetchNewestBooksCubit>().fetchNewestBooks(
      pageNumber: 0,
      searchName: query,
      sord: _sort,
    );
    // Prepare for next page
    _nextPage = 1;
    _attachScrollListener(query);
  }

  void _attachScrollListener(String query) {
    _scrollController.addListener(() {
      if (_scrollController.offset >= _scrollController.position.maxScrollExtent * 0.8 &&
          !_scrollController.position.outOfRange &&
          !_isLoading) {
        setState(() {
          _isLoading = true;
        });
        context.read<FetchNewestBooksCubit>().fetchNewestBooks(
          pageNumber: _nextPage,
          searchName: query,
          sord: _sort,
        );
        setState(() {
          _nextPage++;
        });
      }
    });
  }

  void _openFilters() {
    showModalBottomSheet(
      context: context,
      backgroundColor: kDarkBlackColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        String tempSort = _sort;
        String tempSubject = _subject;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filters',
                    style: TextStyle(fontSize: 18, color: kWhiteColor),
                  ),
                  const SizedBox(height: 12),
                  const Text('Sort by', style: TextStyle(color: kSliverColor)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ChoiceChip(
                        label: const Text('Relevance'),
                        selected: tempSort != 'new',
                        onSelected: (_) =>
                            setModalState(() => tempSort = 'popular'),
                      ),
                      const SizedBox(width: 8),
                      ChoiceChip(
                        label: const Text('Newest'),
                        selected: tempSort == 'new',
                        onSelected: (_) =>
                            setModalState(() => tempSort = 'new'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Subject', style: TextStyle(color: kSliverColor)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: tempSubject,
                    dropdownColor: kDarkBlackColor,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: kBlackOpacityColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'All', child: Text('All')),
                      DropdownMenuItem(
                        value: 'Technology',
                        child: Text('Technology'),
                      ),
                      DropdownMenuItem(
                        value: 'Computers',
                        child: Text('Computers'),
                      ),
                      DropdownMenuItem(
                        value: 'Programming',
                        child: Text('Programming'),
                      ),
                    ],
                    onChanged: (v) =>
                        setModalState(() => tempSubject = v ?? 'All'),
                  ),
                  const SizedBox(height: 16),
                  const Text('Pages', style: TextStyle(color: kSliverColor)),
                  RangeSlider(
                    values: _pageRange,
                    min: 0,
                    max: 1500,
                    divisions: 30,
                    labels: RangeLabels(
                      _pageRange.start.round().toString(),
                      _pageRange.end.round().toString(),
                    ),
                    onChanged: (val) => setModalState(() {
                      _pageRange = val;
                    }),
                  ),
                  const SizedBox(height: 8),
                  const Text('Minimum rating', style: TextStyle(color: kSliverColor)),
                  Slider(
                    value: _minRating,
                    min: 0,
                    max: 5,
                    divisions: 10,
                    label: _minRating.toStringAsFixed(1),
                    onChanged: (val) => setModalState(() {
                      _minRating = val;
                    }),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _sort = tempSort;
                          _subject = tempSubject;
                        });
                        Navigator.of(context).pop();
                        _search(_controller.text.trim(), reset: true);
                      },
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Container(
          margin: const EdgeInsets.only(right: 8),
          child: TextField(
            controller: _controller,
            autofocus: true,
            textInputAction: TextInputAction.search,
            onChanged: _onChanged,
            onSubmitted: (v) => _search(v.trim(), reset: true),
            decoration: InputDecoration(
              filled: true,
              fillColor: kBlackOpacityColor,
              hintText: 'Search books, topics, authors...',
              hintStyle: const TextStyle(color: kSliverIconColor, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              prefixIcon: const Icon(Icons.search, color: kSliverIconColor),
              suffixIcon: IconButton(
                tooltip: 'Filters',
                icon: const Icon(Icons.tune, color: kSliverIconColor),
                onPressed: _openFilters,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Close',
            icon: const Icon(Icons.close),
            onPressed: () => context.go(AppRouter.kHomeView),
          ),
        ],
      ),
      body: BlocConsumer<FetchNewestBooksCubit, FetchNewestBooksState>(
        listener: (context, state) {
          if (state is NewestBooksLoading) {
            setState(() {
              _isLoading = true;
              _results.clear();
            });
          } else if (state is NewestBooksSuccess) {
            setState(() {
              final filtered = state.books.where((b) {
                final pagesOk = (b.pageCount >= _pageRange.start && b.pageCount <= _pageRange.end);
                final ratingOk = (b.averageRating.toDouble() >= _minRating);
                return pagesOk && ratingOk;
              }).toList();
              _results.addAll(filtered);
              _isLoading = false;
            });
          } else if (state is NewestBooksPaginationLoading) {
            setState(() {
              _isLoading = true;
            });
          } else if (state is NewestBooksFailure || state is NewestBooksPaginationFailure) {
            setState(() {
              _isLoading = false;
            });
          }
        },
        builder: (context, state) {
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (!_isLoading && scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent * 0.8) {
                final base = _controller.text.trim().isEmpty ? 'programming' : _controller.text.trim();
                final subjectPart = _subject != 'All' ? '+subject:${_subject.toLowerCase()}' : '';
                final query = '$base$subjectPart';
                _loadNextPage(query);
              }
              return false;
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _results.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= _results.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final book = _results[index];
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: BookListItem(book: book),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _loadNextPage(String query) {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    context.read<FetchNewestBooksCubit>().fetchNewestBooks(
          pageNumber: _nextPage++,
          searchName: query,
          sord: _sort,
        );
  }
}
