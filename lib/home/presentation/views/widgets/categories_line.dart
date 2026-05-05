import 'package:code_books/contants.dart'; // Adjust the path if necessary
import 'package:code_books/home/presentation/manger/FetchNewestBooksCubit/fetch_newest_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesLine extends StatefulWidget {
  const CategoriesLine({super.key});

  @override
  State<CategoriesLine> createState() => _CategoriesLineState();
}

class _CategoriesLineState extends State<CategoriesLine> {
  String selectedText = 'All';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FetchNewestBooksCubit>();

    return BlocBuilder<FetchNewestBooksCubit, FetchNewestBooksState>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildCategoryButton(
                text: 'All',
                isSelected: selectedText == 'All',
                onTap: () {
                  if (mounted) {
                    setState(() {
                      selectedText = 'All';
                      cubit.fetchNewestBooks(pageNumber: 0, sord: 'new');
                    });
                  }
                },
              ),
              _buildCategoryButton(
                text: 'Flutter',
                isSelected: selectedText == 'Flutter',
                onTap: () {
                  if (mounted) {
                    setState(() {
                      selectedText = 'Flutter';
                      cubit.toggleToFlutter();
                    });
                  }
                },
              ),
              _buildCategoryButton(
                text: 'Algorithms',
                isSelected: selectedText == 'Algorithms',
                onTap: () {
                  if (mounted) {
                    setState(() {
                      selectedText = 'Algorithms';
                      cubit.toggleToAlgorithms();
                    });
                  }
                },
              ),
              _buildCategoryButton(
                text: 'JavaScript',
                isSelected: selectedText == 'JavaScript',
                onTap: () {
                  if (mounted) {
                    setState(() {
                      selectedText = 'JavaScript';
                      cubit.toggleToJavaScript();
                    });
                  }
                },
              ),
              _buildCategoryButton(
                text: 'Python',
                isSelected: selectedText == 'Python',
                onTap: () {
                  if (mounted) {
                    setState(() {
                      selectedText = 'Python';
                      cubit.toggleToPython();
                    });
                  }
                },
              ),
              _buildCategoryButton(
                text: 'PHP',
                isSelected: selectedText == 'PHP',
                onTap: () {
                  if (mounted) {
                    setState(() {
                      selectedText = 'PHP';
                      cubit.toggleToPhp();
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 2.5),
        width: 85,
        decoration: isSelected
            ? BoxDecoration(
                color: kPrimaryColor.withValues(alpha: .5),
                borderRadius: BorderRadius.circular(29),
              )
            : BoxDecoration(borderRadius: BorderRadius.circular(0)),
        child: Center(
          child: Text(
            text,
            style: isSelected
                ? const TextStyle(color: kPrimaryColor)
                : const TextStyle(color: kSliverColor),
          ),
        ),
      ),
    );
  }
}
