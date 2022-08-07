import '../../shared_blocs/base/base_bloc.dart';
import 'splash_events.dart';
import 'splash_states.dart';

class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    processEvent<SplashOpen>((event, emit) async {
      await Future.delayed(const Duration(seconds: 3));
      emit(SplashTimeout());
    });
    processEvent<CheckNavigateLogin>((event, emit) {
      event.loginData != null ? emit(NavigateHome()) : emit(NavigateLogin());
    });

    add(SplashOpen());
  }
}
