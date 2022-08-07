import '../../../../../domain/repositories/account_repository.dart';
import '../../../../../domain/repositories/settings_repository.dart';
import '../../../shared_blocs/base/base_bloc.dart';
import 'home_settings_events.dart';
import 'home_settings_states.dart';

class HomeSettingsBloc
    extends BaseBloc<HomeSettingsEvents, HomeSettingsStates> {
  final AccountRepository _accountRepository;
  final SettingsRepository _settingsRepository;

  HomeSettingsBloc(this._accountRepository, this._settingsRepository)
      : super(HomeSettingsInitial()) {
    processEvent<HomeSettingsRequestLogout>((event, emit) async {
      emit(HomeSettingsLoading());
      await _accountRepository.logout();
      emit(HomeSettingsLoaded());
      emit(NavigateLogin());
    });
    processEvent<HomeSettingsInitConfirmExit>((event, emit) async {
      bool isConfirmExit = await _settingsRepository.isConfirmExit();
      emit(HomeSettingsConfirmExitLoaded(isConfirmExit));
    });
    processEvent<HomeSettingsToggleConfirmExit>((event, emit) {
      _settingsRepository.setConfirmExit(event.isConfirmExit);
    });
    add(HomeSettingsInitConfirmExit());
  }
}
