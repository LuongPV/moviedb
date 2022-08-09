import '../../domain/models/direction_response.dart';
import '../../domain/models/nearby_place_response.dart';
import '../../domain/repositories/place_repository.dart';
import '../apis/place_api.dart';
import '../models/direction/direction_response_mapper.dart';
import '../models/near_by_place/nearby_place_response_mapper.dart';

class PlaceRepositoryImpl extends PlaceRepository {
  final PlaceApi _api;

  PlaceRepositoryImpl(this._api);

  @override
  Future<NearbyPlaceResponse> getNearbyPlaces(
      double latitude, double longitude, String type) async {
    return NearbyPlaceResponseMapper()
        .convertToDomain(await _api.getNearbyPlaces(latitude, longitude, type));
  }

  @override
  Future<DirectionResponse> getDirection(
      double srcLat, double srcLng, double dstLat, double dstLng) async {
    return DirectionResponseMapper().convertToDomain(
        await _api.getDirection(srcLat, srcLng, dstLat, dstLng));
  }
}
