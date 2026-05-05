import 'package:code_books/home/domain/entities/book_entity.dart';
import 'package:code_books/home/presentation/views/widgets/book_list_item.dart';
import 'package:flutter/material.dart';

class ResumeBookListView extends StatefulWidget {
  const ResumeBookListView({
    super.key,
    required this.books,
    required this.scrollController,
  });

  final List<BookEntity> books;
  final ScrollController scrollController;

  @override
  State<ResumeBookListView> createState() => _ResumeBookListViewState();
}

class _ResumeBookListViewState extends State<ResumeBookListView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.books.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: size.height * 0.15,
          child: BookListItem(book: widget.books[index]),
        );
      },
    );
  }
}

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
//   late final ScrollController _scrollController;
//   var nextPage = 1;
//   var isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels >=
//           0.7 * _scrollController.position.maxScrollExtent) {
//         if (!isLoading) {
//           isLoading = true;
//           // Fetch the next page of books based on the current state
//           BlocProvider.of<FetchNewestBooksCubit>(context)
//               .fetchNewestBooks(pageNumber: nextPage++)
//               .whenComplete(() => isLoading = false);
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return NotificationListener<ScrollNotification>(
//       onNotification: (ScrollNotification scrollInfo) {
//         if (!isLoading &&
//             scrollInfo.metrics.pixels >=
//                 scrollInfo.metrics.maxScrollExtent * 0.7) {
//           isLoading = true;
//           BlocProvider.of<FetchNewestBooksCubit>(context)
//               .fetchNewestBooks(pageNumber: nextPage++)
//               .whenComplete(() => isLoading = false);
//         }
//         return true;
//       },
//       child: ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         controller: _scrollController,
//         itemCount: widget.books.length,
//         itemBuilder: (context, index) {
//           return SizedBox(
//             height: size.height * 0.15,
//             child: BookListItem(book: widget.books[index]),
//           );
//         },
//       ),
//     );
//   }
// }
