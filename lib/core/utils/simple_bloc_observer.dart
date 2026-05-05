import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    if (kDebugMode) {
      log(change.toString());
      log(bloc.toString());
    }
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      log(bloc.toString());
      log(transition.toString());
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      log(
        'bloc on error ( bloc : $bloc) +++ (error : $error) +++ (stackTrace : $stackTrace) ',
      );
    }
    super.onError(bloc, error, stackTrace);
  }
}
