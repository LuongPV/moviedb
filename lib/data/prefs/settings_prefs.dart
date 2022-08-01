
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPrefs {
  static const String prefSettingsConfirmExit = 'prefSettingsConfirmExit';

  _getSharedPreferences() async => await SharedPreferences.getInstance();

  Future<bool> isConfirmExit() async {
    return (await _getSharedPreferences()).getBool(prefSettingsConfirmExit);
  }

  void setConfirmExit(bool isConfirmExit) async {
    (await _getSharedPreferences()).setBool(prefSettingsConfirmExit, isConfirmExit);
  }

  void clearConfirmExit() async {
    (await _getSharedPreferences()).setBool(prefSettingsConfirmExit, null);
  }

}
