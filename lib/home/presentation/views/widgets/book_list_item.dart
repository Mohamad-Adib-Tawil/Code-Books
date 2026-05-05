import 'package:code_books/contants.dart';
import 'package:code_books/home/domain/entities/book_entity.dart';
import 'package:code_books/home/presentation/views/widgets/book_item.dart';
import 'package:flutter/material.dart';

class BookListItem extends StatelessWidget {
  const BookListItem({super.key, required this.book});

  final BookEntity book;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final author = book.authors.isNotEmpty
        ? book.authors.first
        : 'Unknown author';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width * .18,
            height: size.height * .15,
            child: CustomBookImage(book: book),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 3),
              SizedBox(
                width: size.width * .52,
                child: Text(
                  book.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                width: size.width * .52,
                child: Text(
                  author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, color: kSliverColor),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                "page count : ${book.pageCount}",
                style: const TextStyle(fontSize: 16, color: kPrimaryColor),
              ),
              const SizedBox(height: 2),
            ],
          ),
          // const Spacer(),
          // const Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       '00:42:29',
          //       style: TextStyle(color: kSliverColor),
          //     ),
          //     SizedBox(
          //       height: 5,
          //     ),
          //     Text(
          //       '00:56:37',
          //       style: TextStyle(color: kWhiteColor),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
