import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// AppBlocObserver provides comprehensive real-time monitoring
/// and state transition logging across the entire application.
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    debugPrint('🟢 [BLoC Created] -> ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('⚡ [BLoC Event] -> ${bloc.runtimeType}: $event');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    debugPrint(
      '🔄 [BLoC State Change] -> ${bloc.runtimeType}\n'
      '   ├── From: ${change.currentState}\n'
      '   └── To:   ${change.nextState}',
    );
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    debugPrint(
      '🔀 [BLoC Transition] -> ${bloc.runtimeType}\n'
      '   ├── Event: ${transition.event}\n'
      '   ├── Next:  ${transition.nextState}',
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    debugPrint('🔴 [BLoC Error] -> ${bloc.runtimeType}: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    debugPrint('⚪ [BLoC Closed] -> ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
