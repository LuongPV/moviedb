abstract class SettingsRepository {
  Future<bool> isConfirmExit();

  Future<void> setConfirmExit(bool isConfirmExit);

  Future<void> clearConfirmExit();
}
