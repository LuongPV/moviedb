import 'dart:io';

import 'package:movie_db/data/apis/base_themoviedb_api.dart';
import 'package:movie_db/data/models/trending_media_response.dart';
import 'package:movie_db/data/models/trending_media_type.dart';
import 'package:movie_db/utils/logger/logger.dart';
import 'package:sprintf/sprintf.dart';

import '../constants.dart';

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