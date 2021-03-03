import 'package:flutter/cupertino.dart';
import 'package:movie_db/data/repositories/account_repository.dart';
import 'package:movie_db/data/repositories/settings_repository.dart';
import 'package:movie_db/screens/home/home_settings_widget.dart';

class HomeSettingsController {
  AccountRepository _accountRepository = AccountRepository();
  SettingsRepository _settingsRepository = SettingsRepository();
  HomeSettingsWidgetState homeSettingsWidgetState;
  BuildContext context;
  var isConfirmExit = true;

  HomeSettingsController(this.homeSettingsWidgetState, this.context);

  void logout() {
    homeSettingsWidgetState.widget.showLoadingDialog(context);
    _accountRepository.logout().then((value) {
      homeSettingsWidgetState.widget.hideLoadingDialog(context);
      homeSettingsWidgetState
          .updateUI(() => homeSettingsWidgetState.openLogin());
    });
  }

  void initConfirmExit() {
    _settingsRepository.isConfirmExit().then((value) {
      homeSettingsWidgetState.updateUI(() {
        isConfirmExit = value;
        if (isConfirmExit == null) {
          isConfirmExit = true;
          _settingsRepository.setConfirmExit(isConfirmExit);
        }
      });
    });
  }

  void setConfirmExit(bool isOn) {
    isConfirmExit = isOn;
    _settingsRepository.setConfirmExit(isOn);
  }
}
