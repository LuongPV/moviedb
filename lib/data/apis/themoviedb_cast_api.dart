import 'dart:io';

import 'package:movie_db/data/apis/base_themoviedb_api.dart';
import 'package:movie_db/data/models/cast_by_movie.dart';
import 'package:movie_db/data/models/cast_by_tv_show.dart';
import 'package:movie_db/data/models/cast_detail.dart';
import 'package:movie_db/utils/logger/logger.dart';
import 'package:sprintf/sprintf.dart';

import '../constants.dart';

class TheMovieDbCastAPI extends BaseTheMovieDbAPI {

  Future<CastByMovieResponse> getCastByMovie(int movieId) async {
    try {
      final url = sprintf(URL_MOVIE_DETAIL_CAST, [movieId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = CastByMovieResponse.fromJson(jsonMap);
        response.cast.forEach((item) {
          item.profilePath = appendImageUrl(item.profilePath);
        });
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      throw e;
    }
  }

  Future<CastByTVShowResponse> getCastByTVShow(int movieId) async {
    try {
      final url = sprintf(URL_TV_SHOW_DETAIL_CAST, [movieId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = CastByTVShowResponse.fromJson(jsonMap);
        response.cast.forEach((item) {
          item.profilePath = appendImageUrl(item.profilePath);
        });
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      throw e;
    }
  }

  Future<CastDetail> getCastDetail(int castId) async {
    try {
      final url = sprintf(URL_CAST_DETAIL, [castId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = CastDetail.fromJson(jsonMap);
        response.profilePath = appendImageUrl(response.profilePath);
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      throw e;
    }
  }

}