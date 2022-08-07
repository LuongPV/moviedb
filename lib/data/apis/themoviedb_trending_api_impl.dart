import 'dart:io';

import 'package:sprintf/sprintf.dart';

import '../../domain/models/trending_media_type.dart';
import '../../presentation/utils/logger/logger.dart';
import '../constants.dart';
import '../models/trending_media_response.dart';
import '../models/trending_media_type_ext.dart';
import 'themoviedb_trending_api.dart';

class TheMovieDbTrendingApiImpl extends TheMovieDbTrendingApi {

  @override
  Future<TrendingMediaResponse?> getTrendingMedia(TrendingMediaType type) async {
    try {
      final url = sprintf(urlTrending, [type.name, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = TrendingMediaResponse.fromJson(jsonMap);
        for (var item in response.results) {
          item.posterPath = appendImageUrl(item.posterPath);
          item.backdropPath = appendImageUrl(item.backdropPath);
        }
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      rethrow;
    }
  }

}