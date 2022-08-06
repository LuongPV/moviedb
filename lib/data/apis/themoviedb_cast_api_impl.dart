import 'dart:io';

import 'package:sprintf/sprintf.dart';

import '../../presentation/utils/logger/logger.dart';
import '../constants.dart';
import '../models/cast_by_movie/cast_by_movie.dart';
import '../models/cast_by_tv_show/cast_by_tv_show.dart';
import '../models/cast_detail/cast_detail.dart';
import 'themoviedb_cast_api.dart';

class TheMovieDbCastApiImpl extends TheMovieDbCastApi {
  @override
  Future<CastByMovieResponse?> getCastByMovie(int movieId) async {
    try {
      final url =
          sprintf(urlMovieDetailCast, [movieId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = CastByMovieResponse.fromJson(jsonMap);
        response.cast?.forEach((item) {
          item.profilePath = appendImageUrl(item.profilePath);
        });
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      rethrow;
    }
  }

  @override
  Future<CastByTVShowResponse?> getCastByTVShow(int movieId) async {
    try {
      final url =
          sprintf(urlTvShowDetailCast, [movieId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = CastByTVShowResponse.fromJson(jsonMap);
        response.cast?.forEach((item) {
          item.profilePath = appendImageUrl(item.profilePath);
        });
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      rethrow;
    }
  }

  @override
  Future<CastDetail?> getCastDetail(int castId) async {
    try {
      final url = sprintf(urlCastDetail, [castId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = CastDetail.fromJson(jsonMap);
        response.profilePath = appendImageUrl(response.profilePath);
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      rethrow;
    }
  }
}
