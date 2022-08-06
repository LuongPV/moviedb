import '../../domain/repositories/settings_repository.dart';
import '../prefs/settings_prefs.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final _settingsPref = SettingsPrefs();

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
