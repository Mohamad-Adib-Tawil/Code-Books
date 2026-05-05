import 'package:code_books/contants.dart';
import 'package:code_books/home/presentation/views/widgets/suggetion_book.dart';
import 'package:flutter/material.dart';

class SuginationBook extends StatelessWidget {
  const SuginationBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 100),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.headlineMedium,
            children: const [
              TextSpan(text: "You might also "),
              TextSpan(
                text: "like….",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoaderPageNew()));},
          child: const SuggetionBook(),
        ),
      ],
    );
  }
}
