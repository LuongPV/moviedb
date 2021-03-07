import 'package:movie_db/data/apis/base_api.dart';
import 'package:movie_db/data/constants.dart';
import 'package:movie_db/data/models/direction_response.dart';
import 'package:movie_db/data/models/nearby_place_response.dart';
import 'package:movie_db/utils/logger/logger.dart';
import 'package:sprintf/sprintf.dart';

class PlaceAPI extends BaseAPI {
  Future<NearbyPlaceResponse> getNearbyPlaces(double latitude, double longitude, String type) async {
    try {
      final url = sprintf(URL_GOOGLE_NEARBY_PLACE, [latitude, longitude, type]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = NearbyPlaceResponse.fromJson(jsonMap);
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      throw e;
    }
  }

  Future<DirectionResponse> getDirection(double srcLat, double srcLng, double dstLat, double dstLng) async {
    try {
      final url = sprintf(URL_GOOGLE_DIRECTION, [srcLat, srcLng, dstLat, dstLng]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = DirectionResponse.fromJson(jsonMap);
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      throw e;
    }
  }
}
