import '../../domain/repositories/settings_repository.dart';
import '../prefs/settings_prefs.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsPrefs _settingsPref;

  SettingsRepositoryImpl(this._settingsPref);

  @override
  Future<bool> isConfirmExit() {
    return _settingsPref.isConfirmExit();
  }

  @override
  Future<void> setConfirmExit(bool isConfirmExit) async {
    _settingsPref.setConfirmExit(isConfirmExit);
  }

  @override
  Future<void> clearConfirmExit() async {
    _settingsPref.clearConfirmExit();
  }
}
