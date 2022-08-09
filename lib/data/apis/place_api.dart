import '../models/direction/direction_response.dart';
import '../models/nearby_place_response.dart';
import 'base_api.dart';

abstract class PlaceApi extends BaseApi {
  Future<NearbyPlaceResponse?> getNearbyPlaces(
    double latitude,
    double longitude,
    String type,
  );

  Future<DirectionResponse?> getDirection(
    double srcLat,
    double srcLng,
    double dstLat,
    double dstLng,
  );
}
