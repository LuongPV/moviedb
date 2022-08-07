abstract class HomeSettingsEvents {}

class HomeSettingsRequestLogout extends HomeSettingsEvents {}

class HomeSettingsInitConfirmExit extends HomeSettingsEvents {}

class HomeSettingsToggleConfirmExit extends HomeSettingsEvents {
  final bool isConfirmExit;

  HomeSettingsToggleConfirmExit(this.isConfirmExit);
}
