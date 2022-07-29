import '../prefs/settings_prefs.dart';

class SettingsRepository {
  final _settingsPref = SettingsPrefs();

  Future<bool> isConfirmExit() {
    return _settingsPref.isConfirmExit();
  }

  Future<void> setConfirmExit(bool isConfirmExit) async {
    _settingsPref.setConfirmExit(isConfirmExit);
  }

  Future<void> clearConfirmExit() async {
    _settingsPref.clearConfirmExit();
  }
}
