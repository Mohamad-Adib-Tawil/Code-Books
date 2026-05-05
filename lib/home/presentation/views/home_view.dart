import 'package:code_books/home/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:code_books/home/presentation/manger/popular_books_cubit/cubit/popular_books_cubit_cubit.dart';
import 'package:code_books/home/presentation/manger/FetchNewestBooksCubit/fetch_newest_books_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    // Silent refresh after the first frame to keep cached UI visible.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // Refresh Popular
      context.read<PopularBooksCubit>().fetchPopualrBooks(
        pageNumber: 0,
        searchName: 'programming',
        sord: 'popular',
      );
      // Refresh All (Newest)
      context.read<FetchNewestBooksCubit>().fetchNewestBooks(
        pageNumber: 0,
        searchName: 'programming',
        sord: 'new',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: HomeViewBody());
  }
}
