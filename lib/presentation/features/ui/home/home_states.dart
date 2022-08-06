abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeAppVersionLoaded extends HomeState {
  String version;

  HomeAppVersionLoaded(this.version);
}

class HomeConfirmExitLoaded extends HomeState {
  bool isConfirmExit;

  HomeConfirmExitLoaded(this.isConfirmExit);
}
