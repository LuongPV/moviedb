abstract class HomeSettingsStates {}

class HomeSettingsInitial extends HomeSettingsStates {}

class HomeSettingsLoading extends HomeSettingsStates {}

class HomeSettingsLoaded extends HomeSettingsStates {}

class NavigateLogin extends HomeSettingsStates {}

class HomeSettingsConfirmExitLoaded extends HomeSettingsStates {
  final bool isConfirmExit;

  HomeSettingsConfirmExitLoaded(this.isConfirmExit);
}
