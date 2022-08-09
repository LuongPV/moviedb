import 'package:sprintf/sprintf.dart';

import '../../presentation/utils/logger/logger.dart';
import '../constants.dart';
import '../models/direction/direction_response.dart';
import '../models/near_by_place/nearby_place_response.dart';
import 'place_api.dart';

class PlaceApiImpl extends PlaceApi {
  @override
  Future<NearbyPlaceResponse?> getNearbyPlaces(
    double latitude,
    double longitude,
    String type,
  ) async {
    try {
      final url = sprintf(urlGoogleNearbyPlace, [latitude, longitude, type]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = NearbyPlaceResponse.fromJson(jsonMap);
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      rethrow;
    }
  }

  @override
  Future<DirectionResponse?> getDirection(
    double srcLat,
    double srcLng,
    double dstLat,
    double dstLng,
  ) async {
    try {
      final url =
          sprintf(urlGoogleDirection, [srcLat, srcLng, dstLat, dstLng]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = DirectionResponse.fromJson(jsonMap);
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      rethrow;
    }
  }
}
