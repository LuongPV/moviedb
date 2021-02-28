import 'dart:io';

import 'package:movie_db/data/models/cast_by_movie.dart';
import 'package:movie_db/data/models/cast_by_tv_show.dart';
import 'package:movie_db/data/models/cast_detail.dart';
import 'package:movie_db/data/models/movie_by_cast.dart';
import 'package:movie_db/data/models/movie_by_genre.dart';
import 'package:movie_db/data/models/movie_detail.dart';
import 'package:movie_db/data/models/movie_search.dart';
import 'package:movie_db/data/models/trending_media_response.dart';
import 'package:movie_db/data/models/trending_media_type.dart';
import 'package:movie_db/data/models/tv_show_detail.dart';
import 'package:movie_db/data/repositories/base_api.dart';
import 'package:movie_db/utils/logger/logger.dart';
import 'package:sprintf/sprintf.dart';

import '../constants.dart';

class TheMovieDbAPI extends BaseAPI {

  Future<MovieSearchResponse> searchMovie(String title) async {
    try {
      final url = sprintf(URL_MOVIE_SEARCH, [title, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = MovieSearchResponse.fromJson(jsonMap);
        response.results.forEach((item) {
          item.posterPath = _appendImageUrl(item.posterPath);
          item.backdropPath = _appendImageUrl(item.backdropPath);
        });
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      throw e;
    }
  }

  Future<MovieDetail> getMovieDetail(int movieId) async {
    try {
      final url = sprintf(URL_MOVIE_DETAIL, [movieId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = MovieDetail.fromJson(jsonMap);
        response.posterPath = _appendImageUrl(response.posterPath);
        response.backdropPath = _appendImageUrl(response.backdropPath);
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      throw e;
    }
  }

  Future<MovieByGenreResponse> getMovieByGenre(int genreId) async {
    try {
      final url = sprintf(URL_MOVIE_BY_GENRE, [genreId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = MovieByGenreResponse.fromJson(jsonMap);
        response.results.forEach((item) {
          item.posterPath = _appendImageUrl(item.posterPath);
          item.backdropPath = _appendImageUrl(item.backdropPath);
        });
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      throw e;
    }
  }

  Future<CastByMovieResponse> getCastByMovie(int movieId) async {
    try {
      final url = sprintf(URL_MOVIE_DETAIL_CAST, [movieId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = CastByMovieResponse.fromJson(jsonMap);
        response.cast.forEach((item) {
          item.profilePath = _appendImageUrl(item.profilePath);
        });
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      throw e;
    }
  }

  Future<MovieByCastResponse> getMovieByCast(int castId) async {
    try {
      final url = sprintf(URL_MOVIE_BY_CAST, [castId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = MovieByCastResponse.fromJson(jsonMap);
        response.cast.forEach((item) {
          item.posterPath = _appendImageUrl(item.posterPath);
          item.backdropPath = _appendImageUrl(item.backdropPath);
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
        response.profilePath = _appendImageUrl(response.profilePath);
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      throw e;
    }
  }

  Future<TrendingMediaResponse> getTrendingMedia(TrendingMediaType type) async {
    try {
      final url = sprintf(URL_TRENDING, [type.name, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = TrendingMediaResponse.fromJson(jsonMap);
        response.results.forEach((item) {
          item.posterPath = _appendImageUrl(item.posterPath);
          item.backdropPath = _appendImageUrl(item.backdropPath);
        });
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      throw e;
    }
  }

  Future<TVShowDetail> getTVShowDetail(int movieId) async {
    try {
      final url = sprintf(URL_TV_SHOW_DETAIL, [movieId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = TVShowDetail.fromJson(jsonMap);
        response.posterPath = _appendImageUrl(response.posterPath);
        response.backdropPath = _appendImageUrl(response.backdropPath);
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
          item.profilePath = _appendImageUrl(item.profilePath);
        });
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      throw e;
    }
  }

  String _appendImageUrl(String fileName) {
    if (fileName != null) {
      return fileName = sprintf(URL_MOVIE_IMAGE, [fileName]);
    }
    return null;
  }

}