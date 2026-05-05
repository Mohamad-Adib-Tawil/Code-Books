import 'package:code_books/core/utils/app_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    AppLogger.info(
      '${bloc.runtimeType} change: $change',
      name: 'SimpleBlocObserver',
    );
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    AppLogger.info(
      '${bloc.runtimeType} transition: $transition',
      name: 'SimpleBlocObserver',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    AppLogger.error(
      '${bloc.runtimeType} error',
      error: error,
      stackTrace: stackTrace,
      name: 'SimpleBlocObserver',
    );
    super.onError(bloc, error, stackTrace);
  }
}
