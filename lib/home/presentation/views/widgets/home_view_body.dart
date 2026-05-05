// import 'package:code_books/home/presentation/views/widgets/book_stack_bloc_consumer.dart';
// import 'package:code_books/home/presentation/views/widgets/categories_line.dart';
// import 'package:code_books/home/presentation/views/widgets/custom_app_bar.dart';
// import 'package:code_books/home/presentation/views/widgets/resume_book_list_item_bloc_consumer.dart';
// import 'package:code_books/home/presentation/views/widgets/rotated_text.dart';
// import 'package:flutter/material.dart';
// import '../../../../core/utils/styles.dart';
// import 'text_field.dart';
import 'package:code_books/home/presentation/views/widgets/book_stack_bloc_consumer.dart';
import 'package:code_books/home/presentation/views/widgets/categories_line.dart';
import 'package:code_books/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:code_books/home/presentation/views/widgets/resume_book_list_item_bloc_consumer.dart';
import 'package:code_books/home/presentation/views/widgets/rotated_text.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/styles.dart';
import 'text_field.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          // App bar and text field
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [CustomAppBar(), CustomTextField()],
              ),
            ),
          ),
          // Book stack list
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.36,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const SizedBox(width: 20, child: RotatedText()),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 275,
                    child: const BookStackListBlocConsumer(),
                  ),
                ],
              ),
            ),
          ),
          // Categories and other books
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 15),
                const Text('Other Books', style: Styles.textStyle30),
                const SizedBox(height: 20),
                const SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: CategoriesLine(),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  child: ResumeBookListItemBlocConsumer(
                    scrollController: scrollController,
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
