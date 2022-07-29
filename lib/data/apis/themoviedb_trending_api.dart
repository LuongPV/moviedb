import 'dart:io';

import 'package:sprintf/sprintf.dart';

import '../../utils/logger/logger.dart';
import '../constants.dart';
import '../models/trending_media_response.dart';
import '../models/trending_media_type.dart';
import 'base_themoviedb_api.dart';

class TheMovieDbTrendingAPI extends BaseTheMovieDbAPI {
  Future<TrendingMediaResponse> getTrendingMedia(TrendingMediaType type) async {
    try {
      final url = sprintf(URL_TRENDING, [type.name, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = TrendingMediaResponse.fromJson(jsonMap);
        response.results.forEach((item) {
          item.posterPath = appendImageUrl(item.posterPath);
          item.backdropPath = appendImageUrl(item.backdropPath);
        });
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      throw e;
    }
  }

}