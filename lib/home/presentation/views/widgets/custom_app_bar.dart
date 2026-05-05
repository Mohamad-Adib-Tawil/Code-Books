import 'package:code_books/contants.dart';
import 'package:code_books/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      children: [
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'What Would You\nLike To ',
                style: Styles.textStyle30,
              ),
              TextSpan(
                text: 'Read ?',
                style: Styles.textStyle30.copyWith(color: kPrimaryColor),
              ),
            ],
          ),
        ),
        const Spacer(),
        SizedBox(
          height: size.height * .12,
          width: size.width * .12,
          child: const CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(Icons.person, color: kWhiteColor),
          ),
        ),
      ],
    );
  }
}
