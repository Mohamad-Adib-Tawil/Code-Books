import 'package:code_books/home/domain/entities/book_entity.dart';
import 'package:code_books/home/presentation/views/widgets/book_info_details.dart';
import 'package:flutter/material.dart';

import '../../../../contants.dart';

class BookDetailsItem extends StatelessWidget {
  const BookDetailsItem({super.key, required this.book});
  final BookEntity book;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: size.height * .48,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(
            top: size.height * .12,
            left: size.width * .1,
            right: size.width * .02,
          ),
          decoration: BoxDecoration(
            color: kBlackColor,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 20),
                blurRadius: 33,
                color: const Color(0xFF313131).withValues(alpha: .84),
              ),
            ],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: BookInfoItem(book: book),
        ),
        // Padding(
        //   padding: EdgeInsets.only(top: size.height * .48 - 20),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       ChapterCard(
        //         name: "Money",
        //         chapterNumber: 1,
        //         tag: "Life is about change",
        //         press: () {},
        //       ),
        //       ChapterCard(
        //         name: "Power",
        //         chapterNumber: 2,
        //         tag: "Everything loves power",
        //         press: () {},
        //       ),
        //       ChapterCard(
        //         name: "Influence",
        //         chapterNumber: 3,
        //         tag: "Influence easily like never before",
        //         press: () {},
        //       ),
        //       ChapterCard(
        //         name: "Win",
        //         chapterNumber: 4,
        //         tag: "Winning is what matters",
        //         press: () {},
        //       ),
        //       const SizedBox(height: 10),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
