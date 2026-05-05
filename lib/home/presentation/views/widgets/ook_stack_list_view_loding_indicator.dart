import 'package:code_books/core/widgets/custom_fading_widget.dart';
import 'package:code_books/home/presentation/views/widgets/book_stack_list_item_loading_indicator.dart';
import 'package:flutter/material.dart';

class BookStackListViewLoadingIndicator extends StatefulWidget {
  const BookStackListViewLoadingIndicator({super.key});

  @override
  State<BookStackListViewLoadingIndicator> createState() =>
      _BookStackListViewLoadingIndicatorState();
}

class _BookStackListViewLoadingIndicatorState
    extends State<BookStackListViewLoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return CustomFadingWidget(
      child: SizedBox(
        height: size.height,
        child: ListView.separated(
          itemBuilder: (context, index) {
            return SizedBox(
              height: size.height * 0.15,
              child: const BookStackListItemLoadingIndicator(),
            );
          },
          itemCount: 15,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(width: 20);
          },
        ),
      ),
    );
  }
}
