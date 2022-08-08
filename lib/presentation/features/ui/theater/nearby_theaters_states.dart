import '../../../../data/models/permission_action.dart';
import '../../../../domain/models/direction_response.dart';
import '../../../../domain/models/nearby_place_response.dart';

abstract class NearbyTheaterState {}

class NearbyTheaterInitial extends NearbyTheaterState {}

class NearbyTheaterTimeout extends NearbyTheaterState {}

class LocationLoaded extends NearbyTheaterState {
  double latitude;
  double longitude;

  LocationLoaded(this.latitude, this.longitude);
}

class LocationServiceErrorTriggered extends NearbyTheaterState {
  ServicePermissionAction permissionAction;

  LocationServiceErrorTriggered(this.permissionAction);
}

class NearbyPlacesLoaded extends NearbyTheaterState {
  List<Place> places;

  NearbyPlacesLoaded(this.places);
}

class NearbyDirectionLoaded extends NearbyTheaterState {
  List<Routes> routes;

  NearbyDirectionLoaded(this.routes);
}
