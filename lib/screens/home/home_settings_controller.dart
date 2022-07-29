import '../../data/repositories/account_repository.dart';
import '../../data/repositories/settings_repository.dart';
import '../base/base_stateful_controller.dart';
import 'home_settings_widget.dart';

class HomeSettingsController extends BaseStatefulController<HomeSettingsWidgetState> {
  AccountRepository _accountRepository = AccountRepository();
  SettingsRepository _settingsRepository = SettingsRepository();
  HomeSettingsWidgetState homeSettingsWidgetState;
  var isConfirmExit = true;

  HomeSettingsController(state, context) : super(state, context);

  void logout() {
    homeSettingsWidgetState.widget.showLoadingDialog(context);
    _accountRepository.logout().then((value) {
      homeSettingsWidgetState.widget.hideLoadingDialog(context);
      homeSettingsWidgetState.openLogin();
    });
  }

  void initConfirmExit() {
    _settingsRepository.isConfirmExit().then((value) {
      isConfirmExit = value;
      if (isConfirmExit == null) {
        isConfirmExit = true;
        _settingsRepository.setConfirmExit(isConfirmExit);
      }
      updateUI();
    });
  }

  void setConfirmExit(bool isOn) {
    isConfirmExit = isOn;
    _settingsRepository.setConfirmExit(isOn);
  }
}
