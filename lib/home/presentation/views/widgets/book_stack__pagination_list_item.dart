import 'package:code_books/core/widgets/custom_fading_widget.dart';
import 'package:flutter/material.dart';

class BookStackPaginationListItem extends StatelessWidget {
  const BookStackPaginationListItem({super.key});
  @override
  Widget build(BuildContext context) {
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
                color: Colors.grey.shade900,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 20,
            child: SizedBox(
              width: 134,
              height: 195,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CustomFadingWidget(
                  child: SizedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 45,
            left: 30,
            child: CustomFadingWidget(
              child: SizedBox(
                height: 2,
                width: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(color: Colors.grey),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 30,
            child: SizedBox(
              width: 150,
              child: CustomFadingWidget(
                child: SizedBox(
                  height: 2,
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
