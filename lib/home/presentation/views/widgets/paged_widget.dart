// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// class RoomBodyListViewWidget extends StatefulWidget {
//   const RoomBodyListViewWidget({
//     super.key,
//     required this.roomCubit,
//     required this.userCubit,
//   });

//   final RoomCubit roomCubit;
//   final UserCubit userCubit;

//   @override
//   State<RoomBodyListViewWidget> createState() => _RoomBodyListViewWidgetState();
// }

// class _RoomBodyListViewWidgetState extends State<RoomBodyListViewWidget> {
//   static const _pageSize = 10;
//   final PagingController<int, RoomEntity> _pagingController =
//       PagingController(firstPageKey: 1);
//   bool showHeader = true;
//   final ScrollController _scrollController = ScrollController();
//   double previousScrollPosition = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _pagingController.addPageRequestListener((pageKey) {
//       _fetchPage(pageKey);
//     });

//     _scrollController.addListener(() {
//       final maxScroll = _scrollController.position.maxScrollExtent;
//       final currentScroll = _scrollController.position.pixels;
//       log('Home $currentScroll $previousScrollPosition currentScroll > previousScrollPosition ${currentScroll > previousScrollPosition}');

//       if (currentScroll > 0) {
//         if (currentScroll > previousScrollPosition) {
//           if (showHeader) {
//             setState(() {
//               showHeader = false;
//             });
//           }
//         } else {
//           // Scrolling up
//           if (!showHeader) {
//             setState(() {
//               showHeader = true;
//             });
//           }
//         }
//       }

//       previousScrollPosition = currentScroll;
//     });
//   }

//   Future<void> _fetchPage(int pageKey) async {
//     try {
//       final newItems = await widget.roomCubit.fetchRooms(pageKey);
//       final isLastPage = newItems.length < _pageSize;

//       if (isLastPage) {
//         _pagingController.appendLastPage(newItems);
//       } else {
//         final nextPageKey = pageKey + 1;
//         _pagingController.appendPage(newItems, nextPageKey);
//       }
//     } catch (error) {
//       _pagingController.error = error;
//     }
//   }

//   @override
//   void dispose() {
//     _pagingController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width;
//     const double hightImages = 80;

//     return BlocConsumer<RoomCubit, RoomCubitState>(
//       bloc: widget.roomCubit,
//       listener: (context, state) {
//         // Add your listener logic here if needed
//       },
//       builder: (context, state) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14),
//           child: Column(
//             children: [
//               if (showHeader) slideSection(hightImages, width),
//               const SizedBox(
//                 height: 5,
//               ),
//               Expanded(
//                 child: roomListViewPaged(),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   PagedListView<int, RoomEntity> roomListViewPaged() {
//     return PagedListView<int, RoomEntity>(
//       scrollController: _scrollController,
//       pagingController: _pagingController,
//       builderDelegate: PagedChildBuilderDelegate<RoomEntity>(
//         itemBuilder: (context, item, index) => RoomItemWidgetTitlesContainer(
//           index: index,
//           roomCubit: widget.roomCubit,
//           rooms: item,
//           userCubit: widget.userCubit,
//         ),
//       ),
//     );
//   }

// class HomeViewBody extends StatelessWidget {
//   const HomeViewBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: CustomScrollView(
//         slivers: [
//           // App bar and text field
//           const SliverPadding(
//             padding: EdgeInsets.symmetric(horizontal: 24),
//             sliver: SliverToBoxAdapter(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CustomAppBar(),
//                   CustomTextField(),
//                 ],
//               ),
//             ),
//           ),
//           // Book stack list
//           SliverToBoxAdapter(
//             child: SizedBox(
//               height: MediaQuery.of(context).size.height * 0.36,
//               child: Row(
//                 children: [
//                   const SizedBox(width: 10),
//                   const SizedBox(
//                     width: 20,
//                     child: RotatedText(),
//                   ),
//                   const SizedBox(width: 12),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width - 50,
//                     height: 275,
//                     child: const BookStackListBlocConsumer(),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // Categories and other books
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             sliver: SliverList(
//               delegate: SliverChildListDelegate([
//                 const SizedBox(height: 15),
//                 const SizedBox(
//                   width: double.infinity,
//                   height: 40,
//                   child: CategoriesLine(),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text('Other Books', style: Styles.textStyle30),
//                 const SizedBox(height: 10),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height
//                   , // Example fixed height
//                   child: const ResumeBookListItemBlocConsumer(),
//                 ),
//               ]),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // import 'package:code_books/home/domain/entities/book_entity.dart';
// // import 'package:code_books/home/presentation/manger/popular_books_cubit/cubit/popular_books_cubit_cubit.dart';
// // import 'package:code_books/home/presentation/views/widgets/book_list_item.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:code_books/home/domain/entities/book_entity.dart';
// import 'package:code_books/home/presentation/manger/FetchNewestBooksCubit/fetch_newest_books_cubit.dart';
// import 'package:code_books/home/presentation/manger/popular_books_cubit/cubit/popular_books_cubit_cubit.dart';
// import 'package:code_books/home/presentation/views/widgets/book_list_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// class ResumeBookListView extends StatefulWidget {
//   const ResumeBookListView({
//     super.key,
//     required this.books,
//   });
//   final List<BookEntity> books;

//   @override
//   State<ResumeBookListView> createState() => _ResumeBookListViewState();
// }

// class _ResumeBookListViewState extends State<ResumeBookListView> {
//   final ScrollController _scrollController = ScrollController();
//   final PagingController<int, BookEntity> _pagingController =
//       PagingController(firstPageKey: 1); // Ensure firstPageKey starts with 1
//   double previousScrollPosition = 0.0;
//   var nextPage = 1;
//   var isLoading = false;
//   bool showHeader = true;
//   static const _pageSize = 10;

//   @override
//   void initState() {
//     super.initState();
//     _pagingController.addPageRequestListener((pageKey) {
//       _fetchPage(pageKey);
//     });

//     _scrollController.addListener(() {
//       final maxScroll = _scrollController.position.maxScrollExtent;
//       final currentScroll = _scrollController.position.pixels;

//       if (currentScroll > 0) {
//         if (currentScroll > previousScrollPosition) {
//           if (showHeader) {
//             setState(() {
//               showHeader = false;
//             });
//           }
//         } else {
//           if (!showHeader) {
//             setState(() {
//               showHeader = true;
//             });
//           }
//         }
//       }

//       previousScrollPosition = currentScroll;
//     });
//   }

//   Future<void> _fetchPage(int pageKey) async {
//     try {
//       // Check if the widget is still mounted
//       if (!mounted) return;

//       final result = await BlocProvider.of<FetchNewestBooksCubit>(context)
//           .fetchNewestBooks(pageNumber: pageKey);

//       result.fold(
//         (failure) {
//           // Check if the widget is still mounted
//           if (!mounted) return;
//           isLoading = false;
//         },
//         (newItems) {
//           // Check if the widget is still mounted
//           if (!mounted) return;
//           isLoading = false;

//           final isLastPage = newItems.length < _pageSize;

//           if (isLastPage) {
//             _pagingController.appendLastPage(newItems);
//           } else {
//             final nextPageKey = pageKey + 1;
//             _pagingController.appendPage(newItems, nextPageKey);
//           }
//         },
//       );
//     } catch (error) {
//       // Check if the widget is still mounted
//       if (!mounted) return;
//       _pagingController.error = error;
//     }
//   }

//   @override
//   void dispose() {
//     _pagingController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PagedListView<int, BookEntity>(
//       pagingController: _pagingController,
//       builderDelegate: PagedChildBuilderDelegate<BookEntity>(
//         itemBuilder: (context, item, index) {
//           return SizedBox(
//             height: MediaQuery.of(context).size.height * 0.15,
//             child: BookListItem(book: item),
//           );
//         },
//       ),
//     );
//   }
// }
