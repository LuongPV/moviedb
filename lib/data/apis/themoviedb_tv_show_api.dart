import 'dart:io';

import 'package:movie_db/data/apis/base_themoviedb_api.dart';
import 'package:movie_db/data/models/tv_show_detail.dart';
import 'package:movie_db/utils/logger/logger.dart';
import 'package:sprintf/sprintf.dart';

import '../constants.dart';

class TheMovieDbTVShowAPI extends BaseTheMovieDbAPI {

  Future<TVShowDetail> getTVShowDetail(int movieId) async {
    try {
      final url = sprintf(URL_TV_SHOW_DETAIL, [movieId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = TVShowDetail.fromJson(jsonMap);
        response.posterPath = appendImageUrl(response.posterPath);
        response.backdropPath = appendImageUrl(response.backdropPath);
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      throw e;
    }
  }

}