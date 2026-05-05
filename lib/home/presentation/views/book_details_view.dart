import 'package:code_books/home/domain/entities/book_entity.dart';
import 'package:code_books/home/presentation/views/widgets/book_details_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../contants.dart';

class BoookDetailsView extends StatelessWidget {
  const BoookDetailsView({super.key, required this.book});

  final BookEntity book;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBlackColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF313131).withValues(alpha: .35),

        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          tooltip: 'Back',
          icon: const Icon(Icons.arrow_back_ios_new, color: kWhiteColor),
          onPressed: () => context.pop(),
        ),
        title: Text(
          book.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BookDetailsBody(book: book),
    );
  }
}
