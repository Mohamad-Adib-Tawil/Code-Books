import 'package:code_books/home/presentation/views/widgets/book_stack__pagination_list_item.dart';
import 'package:flutter/material.dart';

class BookStackPAginationListView extends StatefulWidget {
  const BookStackPAginationListView({super.key});

  @override
  State<BookStackPAginationListView> createState() => _BookStackListViewState();
}

class _BookStackListViewState extends State<BookStackPAginationListView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return SizedBox(
            height: size.height * 0.15,
            child: const BookStackPaginationListItem(),
          );
        },
        itemCount: 20,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 20);
        },
      ),
    );
  }
}
