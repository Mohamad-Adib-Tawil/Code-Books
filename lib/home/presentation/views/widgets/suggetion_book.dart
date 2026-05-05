import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_books/home/data/models/book_model/book_model.dart';
import 'package:code_books/home/domain/entities/book_entity.dart';
import 'package:code_books/home/presentation/views/widgets/book_rating.dart';
import 'package:code_books/home/presentation/views/widgets/rounded_button.dart';
import 'package:go_router/go_router.dart';
import 'package:code_books/core/utils/app_router.dart';
import 'package:flutter/material.dart';

import '../../../../contants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SuggetionBook extends StatefulWidget {
  const SuggetionBook({super.key});

  @override
  State<SuggetionBook> createState() => _SuggetionBookState();
}

class _SuggetionBookState extends State<SuggetionBook> {
  final String apiUrlBase =
      'https://www.googleapis.com/books/v1/volumes?filter=free-ebooks&q=programming&startIndex=';
  BookModel? randomBook;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchRandomBook();
  }

  Future<void> fetchRandomBook() async {
    try {
      final randomPage = Random().nextInt(40) + 1;
      final apiUrl = '$apiUrlBase$randomPage';
      final response = await http.get(Uri.parse(apiUrl));

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final items = data['items'] as List<dynamic>?;
        if (items != null && items.isNotEmpty) {
          final randomIndex = Random().nextInt(items.length);
          setState(() {
            randomBook = BookModel.fromJson(
              items[randomIndex] as Map<String, dynamic>,
            );
            isLoading = false;
            errorMessage = null;
          });
        } else {
          setState(() {
            randomBook = null;
            isLoading = false;
            errorMessage = null;
          });
        }
      } else {
        setState(() {
          randomBook = null;
          isLoading = false;
          errorMessage = 'Failed to load books';
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          randomBook = null;
          isLoading = false;
          errorMessage = 'Failed to load books';
        });
      }
    }
  }

  Widget _buildBookContent() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return const Center(
        child: Text(
          'Failed to load books',
          style: TextStyle(color: kWhiteColor),
        ),
      );
    }

    if (randomBook == null) {
      return const Center(
        child: Text('No books found', style: TextStyle(color: kWhiteColor)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text.rich(
          TextSpan(
            style: const TextStyle(color: kWhiteColor),
            children: [
              TextSpan(
                text: "${randomBook!.title}\n",
                style: const TextStyle(fontSize: 15),
              ),
              TextSpan(
                text: randomBook!.authors.isNotEmpty
                    ? randomBook!.authors.first
                    : 'Unknown author',
                style: const TextStyle(color: kSliverColor),
              ),
            ],
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            BookRating(score: randomBook!.averageRating),
            const SizedBox(width: 10),
            Expanded(
              child: RoundedButton(
                color: kPrimaryColor,
                press: () {
                  context.push(
                    AppRouter.kBookDetailsView,
                    extra: randomBook as BookEntity,
                  );
                },
                text: "Read",
                verticalPadding: 10,
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    void openDetails() {
      if (randomBook != null) {
        context.push(
          AppRouter.kBookDetailsView,
          extra: randomBook as BookEntity,
        );
      }
    }

    return GestureDetector(
      onTap: openDetails,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          Container(
            height: 210,
            width: double.infinity,
            decoration: const BoxDecoration(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(left: 24, top: 24, right: 150),
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29),
                color: kBlackColor,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 33,
                    color: const Color(0xFF313131).withValues(alpha: .84),
                  ),
                ],
              ),
              child: _buildBookContent(),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: SizedBox(
              height: 180,
              width: 120,
              child:
                  randomBook != null &&
                      randomBook!.imageLinksThumbnail.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: randomBook!.imageLinksThumbnail,
                      width: 150,
                      fit: BoxFit.fitWidth,
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
