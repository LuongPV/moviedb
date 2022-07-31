import '../models/direction_response.dart';
import '../models/nearby_place_response.dart';

abstract class PlaceRepository {
  Future<NearbyPlaceResponse> getNearbyPlaces(
    double latitude,
    double longitude,
    String type,
  );

  Future<DirectionResponse> getDirection(
    double srcLat,
    double srcLng,
    double dstLat,
    double dstLng,
  );
}
