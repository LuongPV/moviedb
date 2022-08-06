import 'package:sprintf/sprintf.dart';

import '../../presentation/utils/logger/logger.dart';
import '../constants.dart';
import '../models/direction_response.dart';
import '../models/nearby_place_response.dart';
import 'base_api.dart';

class PlaceApi extends BaseApi {
  Future<NearbyPlaceResponse?> getNearbyPlaces(
    double latitude,
    double longitude,
    String type,
  ) async {
    try {
      final url = sprintf(URL_GOOGLE_NEARBY_PLACE, [latitude, longitude, type]);
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

  Future<DirectionResponse?> getDirection(
    double srcLat,
    double srcLng,
    double dstLat,
    double dstLng,
  ) async {
    try {
      final url =sprintf(URL_GOOGLE_DIRECTION, [srcLat, srcLng, dstLat, dstLng]);
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
