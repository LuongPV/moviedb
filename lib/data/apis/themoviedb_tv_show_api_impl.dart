import 'dart:io';

import 'package:sprintf/sprintf.dart';

import '../../presentation/utils/logger/logger.dart';
import '../constants.dart';
import '../models/tv_show_detail.dart';
import 'themoviedb_tv_show_api.dart';

class TheMovieDbTVShowApiImpl extends TheMovieDbTVShowApi {
  @override
  Future<TVShowDetail?> getTVShowDetail(int movieId) async {
    try {
      final url = sprintf(urlTvShowDetail, [movieId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = TVShowDetail.fromJson(jsonMap);
        response.posterPath = appendImageUrl(response.posterPath);
        response.backdropPath = appendImageUrl(response.backdropPath);
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      rethrow;
    }
  }
}
