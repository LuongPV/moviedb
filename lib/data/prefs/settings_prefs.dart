
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPrefs {
  static const String PREF_SETTINGS_CONFIRM_EXIT = 'PREF_SETTINGS_CONFIRM_EXIT';

  _getSharedPreferences() async => await SharedPreferences.getInstance();

  Future<bool> isConfirmExit() async {
    return (await _getSharedPreferences()).getBool(PREF_SETTINGS_CONFIRM_EXIT);
  }

  void setConfirmExit(bool isConfirmExit) async {
    (await _getSharedPreferences()).setBool(PREF_SETTINGS_CONFIRM_EXIT, isConfirmExit);
  }

  void clearConfirmExit() async {
    (await _getSharedPreferences()).setBool(PREF_SETTINGS_CONFIRM_EXIT, null);
  }

}
