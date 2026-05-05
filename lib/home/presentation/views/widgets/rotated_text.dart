import 'package:code_books/contants.dart';
import 'package:code_books/home/presentation/manger/popular_books_cubit/cubit/popular_books_cubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RotatedText extends StatefulWidget {
  const RotatedText({super.key});

  @override
  State<RotatedText> createState() => _RotatedTextState();
}

class _RotatedTextState extends State<RotatedText> {
  String selectedText = 'Popular';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularBooksCubit, PopularBooksCubitState>(
      builder: (context, snapshot) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildRotatedText(
              text: 'New',
              isSelected: selectedText == 'New',
              onTap: () {
                if (mounted) {
                  setState(() {
                    selectedText = 'New';
                    context.read<PopularBooksCubit>().toggleToNewest();
                  });
                }
              },
            ),
            const SizedBox(height: 4),
            _buildRotatedText(
              text: 'Trend',
              isSelected: selectedText == 'Trend',
              onTap: () {
                if (mounted) {
                  setState(() {
                    selectedText = 'Trend';
                    context.read<PopularBooksCubit>().toggleToTrend();
                  });
                }
              },
            ),
            const SizedBox(height: 4),
            _buildRotatedText(
              text: 'Popular',
              isSelected: selectedText == 'Popular',
              onTap: () {
                if (mounted) {
                  setState(() {
                    selectedText = 'Popular';
                    context.read<PopularBooksCubit>().fetchPopualrBooks();
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildRotatedText({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return RotatedBox(
      quarterTurns: 3,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            color: isSelected ? Colors.white : kSliverColor,
            fontSize: isSelected
                ? 18
                : 16, // You can also animate font size or other properties if desired
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
