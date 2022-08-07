import '../../domain/repositories/place_repository.dart';
import '../apis/place_api.dart';
import '../models/direction_response.dart';
import '../models/nearby_place_response.dart';

class PlaceRepositoryImpl extends PlaceRepository {
  final PlaceApi _api;

  PlaceRepositoryImpl(this._api);

  @override
  Future<NearbyPlaceResponse> getNearbyPlaces(
      double latitude, double longitude, String type) {
    return _api.getNearbyPlaces(latitude, longitude, type);
  }

  @override
  Future<DirectionResponse> getDirection(
      double srcLat, double srcLng, double dstLat, double dstLng) {
    return _api.getDirection(srcLat, srcLng, dstLat, dstLng);
  }
}
