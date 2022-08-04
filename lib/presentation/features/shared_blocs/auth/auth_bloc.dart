import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../../../domain/repositories/account_repository.dart';
import '../base/base_bloc.dart';
import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  final AccountRepository _accountRepository;

  AuthBloc(this._accountRepository) : super(AuthInitial()) {
    on<CheckLogin>(((event, emit) async {
      final loginData = await _accountRepository.getLoginData();
      emit(LoginDataLoaded(loginData));
    }), transformer: sequential());
  }
}
