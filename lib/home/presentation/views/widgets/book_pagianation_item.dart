import 'package:code_books/core/widgets/custom_fading_widget.dart';
import 'package:flutter/material.dart';

class BookPaginationListItem extends StatelessWidget {
  const BookPaginationListItem({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomFadingWidget(
            child: SizedBox(
              width: size.width * .18,
              height: size.height * .15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 3),
              Expanded(
                child: CustomFadingWidget(
                  child: SizedBox(
                    height: 2,
                    width: size.width - 60 - size.height * .15,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: CustomFadingWidget(
                  child: SizedBox(
                    height: 2,
                    width: size.width - 60 - size.height * .15,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: CustomFadingWidget(
                  child: SizedBox(
                    height: 2,
                    width: size.width - 60 - size.height * .15,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
