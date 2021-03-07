import 'package:movie_db/data/apis/place_api.dart';
import 'package:movie_db/data/models/direction_response.dart';
import 'package:movie_db/data/models/nearby_place_response.dart';

class PlaceRepository {
  final _api = PlaceAPI();

  Future<NearbyPlaceResponse> getNearbyPlaces(double latitude, double longitude, String type) {
    return _api.getNearbyPlaces(latitude, longitude, type);
  }

  Future<DirectionResponse> getDirection(double srcLat, double srcLng, double dstLat, double dstLng) {
    return _api.getDirection(srcLat, srcLng, dstLat, dstLng);
  }
}
