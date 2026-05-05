import 'package:code_books/core/widgets/custom_fading_widget.dart';
import 'package:code_books/home/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/app_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomBookImage extends StatelessWidget {
  const CustomBookImage({super.key, required this.book});
  final BookEntity book;
  // final BookEntity indexBook;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.kBookDetailsView, extra: book);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: book.imageLinksSmallThumbnail.isNotEmpty
            ? CachedNetworkImage(
                placeholder: (context, url) => CustomFadingWidget(
                  child: SizedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(color: Colors.grey),
                    ),
                  ),
                ),
                // placeholderFadeInDuration: const Duration(milliseconds: 800),
                imageUrl: book.imageLinksSmallThumbnail,
                fit: BoxFit.fill,
              )
            : Image.asset('assets/images/logo.png'),
        // Image.asset(image, fit: BoxFit.fill),
      ),
    );
  }
}
