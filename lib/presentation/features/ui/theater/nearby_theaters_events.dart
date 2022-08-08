import '../../../../domain/models/login_data.dart';

abstract class NearbyTheaterEvent {}

class NearbyTheaterOpen extends NearbyTheaterEvent {}

class CheckNavigateLogin extends NearbyTheaterEvent {
  final LoginData? loginData;

  CheckNavigateLogin(this.loginData);
}

class GetLocation extends NearbyTheaterEvent {}

class GetDirection extends NearbyTheaterEvent {
  double latitude;
  double longitude;

  GetDirection(this.latitude, this.longitude);
}
