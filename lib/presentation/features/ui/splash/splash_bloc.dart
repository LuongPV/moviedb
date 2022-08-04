import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../shared_blocs/base/base_bloc.dart';
import 'splash_events.dart';
import 'splash_states.dart';

class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashOpen>((event, emit) {
      Future.delayed(
        const Duration(seconds: 3),
      ).then((_) async {
        emit(SplashTimeout());
      });
    }, transformer: sequential());
    on<CheckNavigateLogin>((event, emit) {
      event.loginData != null ? emit(NavigateHome()) : emit(NavigateLogin());
    }, transformer: sequential());

    add(SplashOpen());
  }
}
