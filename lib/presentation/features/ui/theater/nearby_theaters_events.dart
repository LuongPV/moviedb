
import '../../../../domain/models/login_data.dart';

abstract class NearbyTheaterEvent {}

class NearbyTheaterOpen extends NearbyTheaterEvent {}

class CheckNavigateLogin extends NearbyTheaterEvent {
  final LoginData? loginData;

  CheckNavigateLogin(this.loginData);
}
