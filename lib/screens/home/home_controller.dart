import 'package:flutter/cupertino.dart';
import 'package:movie_db/data/repositories/settings_repository.dart';
import 'package:movie_db/screens/home/home_widget.dart';

class HomeController {
  SettingsRepository _settingsRepository = SettingsRepository();
  HomeWidgetState state;
  BuildContext context;
  var isConfirmExit;

  HomeController(this.state, this.context);

  void initConfirmExit() {
    _settingsRepository.isConfirmExit().then((value) {
      state.updateUI(() {
        isConfirmExit = value;
      });
    });
  }
}
