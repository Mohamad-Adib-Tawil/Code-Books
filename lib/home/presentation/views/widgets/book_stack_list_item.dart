import 'package:code_books/contants.dart';
import 'package:code_books/home/presentation/views/widgets/book_item.dart';
import 'package:flutter/material.dart';
import 'package:code_books/home/domain/entities/book_entity.dart';

class BookStackListItem extends StatelessWidget {
  const BookStackListItem({super.key, required this.book});
  final BookEntity book;
  @override
  Widget build(BuildContext context) {
    final author = book.authors.isNotEmpty
        ? book.authors.first
        : 'Unknown author';
    return SizedBox(
      height: 255,
      width: 194,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 221,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: kPrimaryColor,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 20,
            child: SizedBox(
              width: 134,
              height: 195,
              child: CustomBookImage(book: book),
            ),
          ),
          Positioned(
            bottom: 45,
            left: 30,
            child: SizedBox(
              width: 150,
              child: Text(
                book.title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: kWhiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 30,
            child: SizedBox(
              width: 150,
              child: Text(
                author,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
