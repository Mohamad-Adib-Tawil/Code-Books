import 'package:code_books/core/utils/api_services.dart';
import 'package:code_books/home/data/data_sources/home_local_data_source.dart';
import 'package:code_books/home/data/data_sources/home_remote_data_source.dart';
import 'package:code_books/home/data/repos_data/home_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  if (getIt.isRegistered<ApiServices>()) {
    return;
  }

  final apiServices = ApiServices(Dio());
  getIt.registerSingleton<ApiServices>(apiServices);

  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      HomeRemoteDataSourceImpl(apiServices: apiServices),
      HomeLocalDataSourceImpl(),
    ),
  );
}
