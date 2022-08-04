
import '../../../../domain/models/login_data.dart';

abstract class SplashEvent {}

class SplashOpen extends SplashEvent {}

class CheckNavigateLogin extends SplashEvent {
  final LoginData? loginData;

  CheckNavigateLogin(this.loginData);
}
