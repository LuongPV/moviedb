import 'dart:convert';
import 'dart:io';

import 'package:movie_db/data/models/cast.dart';
import 'package:movie_db/data/models/cast_by_movie.dart';
import 'package:movie_db/data/models/cast_detail.dart';
import 'package:movie_db/data/models/movie_by_cast.dart';
import 'package:movie_db/data/models/movie_by_genre.dart';
import 'package:movie_db/data/models/movie_detail.dart';
import 'package:movie_db/data/models/movie_search.dart';
import 'package:movie_db/data/models/trending_media_response.dart';
import 'package:movie_db/data/models/trending_media_type.dart';
import 'package:movie_db/data/repositories/base_api.dart';
import 'package:movie_db/utils/logger/logger.dart';

import '../constants.dart';

class TheMovieDbAPI extends BaseAPI {

  Future<MovieSearchResponse> searchMovie(String title) async {
    try {
      final url = BASE_URL_MOVIE_SEARCH + QUERY_API_KEY + API_KEY + _getLanguageQuery() +
              QUERY_MOVIE_TITLE + title;
      final response = await executeGetRequest(url);
      return _convertMovieSearchResponse(response);
    } catch (e) {
      Logger.w('API Exception $e');
      throw e;
    }
  }

  MovieSearchResponse _convertMovieSearchResponse(String jsonBody) {
    final responseMapData = jsonDecode(jsonBody);
    return _appendBaseUrlMovieSearch(MovieSearchResponse.fromJson(responseMapData));
  }

  MovieSearchResponse _appendBaseUrlMovieSearch(MovieSearchResponse searchMovieResponse) {
    searchMovieResponse.results.forEach((item) {
      if (item.posterPath != null) {
        item.posterPath = BASE_URL_MOVIE_IMAGE + item.posterPath;
      }
      if (item.backdropPath != null) {
        item.backdropPath = BASE_URL_MOVIE_IMAGE + item.backdropPath;
      }
    });
    return searchMovieResponse;
  }

  Future<MovieDetail> getMovieDetail(int movieId) async {
    final url = BASE_URL_MOVIE_DETAIL + movieId.toString() + QUERY_API_KEY + API_KEY + _getLanguageQuery();
    final response = await executeGetRequest(url);
    return _convertMovieDetailResponse(response);
  }

  MovieDetail _convertMovieDetailResponse(String jsonBody) {
    final responseMapData = jsonDecode(jsonBody);
    try {
      return _appendBaseUrlMovieDetail(MovieDetail.fromJson(responseMapData));
    } catch (e) {
      Logger.w('Parse search data fail detail = $e');
    }
    return null;
  }

  MovieDetail _appendBaseUrlMovieDetail(MovieDetail movieDetailResponse) {
    if (movieDetailResponse.posterPath != null) {
      movieDetailResponse.posterPath = BASE_URL_MOVIE_IMAGE + movieDetailResponse.posterPath;
    }
    if (movieDetailResponse.backdropPath != null) {
      movieDetailResponse.backdropPath = BASE_URL_MOVIE_IMAGE + movieDetailResponse.backdropPath;
    }
    return movieDetailResponse;
  }

  Future<MovieByGenreResponse> getMovieByGenre(int genreId) async {
    final url = BASE_URL_MOVIE_BY_GENRE + QUERY_API_KEY + API_KEY  + _getLanguageQuery() + QUERY_MOVIE_BY_GENRE + genreId.toString();
    final response = await executeGetRequest(url);
    return _convertMovieByGenreResponse(response);
  }

  MovieByGenreResponse _convertMovieByGenreResponse(String jsonBody) {
    final responseMapData = jsonDecode(jsonBody);
    try {
      return _appendBaseUrlMovieByGenre(MovieByGenreResponse.fromJson(responseMapData));
    } catch (e) {
      Logger.w('Parse search data fail detail = $e');
    }
    return null;
  }

  MovieByGenreResponse _appendBaseUrlMovieByGenre(MovieByGenreResponse searchMovieResponse) {
    searchMovieResponse.results.forEach((item) {
      if (item.posterPath != null) {
        item.posterPath = BASE_URL_MOVIE_IMAGE + item.posterPath;
      }
      if (item.backdropPath != null) {
        item.backdropPath = BASE_URL_MOVIE_IMAGE + item.backdropPath;
      }
    });
    return searchMovieResponse;
  }

  String _getLanguageQuery() {
    return QUERY_API_LANGUAGE + Platform.localeName;
  }

  Future<CastByMovieResponse> getCastByMovie(int movieId) async {
    final url = BASE_URL_MOVIE_DETAIL + movieId.toString() + PATH_MOVIE_DETAIL_CAST + QUERY_API_KEY + API_KEY + _getLanguageQuery();
    final response = await executeGetRequest(url);
    return _convertCastByMovieResponse(response);
  }

  CastByMovieResponse _convertCastByMovieResponse(String jsonBody) {
    final responseMapData = jsonDecode(jsonBody);
    try {
      return _appendBaseUrlCastByMovie(CastByMovieResponse.fromJson(responseMapData));
    } catch (e) {
      Logger.w('Parse data fail detail = $e');
    }
    return null;
  }

  CastByMovieResponse _appendBaseUrlCastByMovie(CastByMovieResponse response) {
    response.cast.forEach((cast) {
      if (cast.profilePath != null) {
        cast.profilePath = BASE_URL_MOVIE_IMAGE + cast.profilePath;
      }
    });
    return response;
  }

  Future<MovieByCastResponse> getMovieByCast(int castId) async {
    try {
      final url = BASE_URL_MOVIE_BY_CAST + castId.toString() + PATH_MOVIE_BY_CAST + QUERY_API_KEY + API_KEY + _getLanguageQuery();
      final response = await executeGetRequest(url);
      return _convertMovieByCastResponse(response);
    } catch (e) {
      Logger.w('API Exception $e');
      throw e;
    }
  }

  MovieByCastResponse _convertMovieByCastResponse(String jsonBody) {
    final responseMapData = jsonDecode(jsonBody);
    return _appendBaseUrlMovieByCast(MovieByCastResponse.fromJson(responseMapData));
  }

  MovieByCastResponse _appendBaseUrlMovieByCast(MovieByCastResponse response) {
    response.cast.forEach((item) {
      if (item.posterPath != null) {
        item.posterPath = BASE_URL_MOVIE_IMAGE + item.posterPath;
      }
      if (item.backdropPath != null) {
        item.backdropPath = BASE_URL_MOVIE_IMAGE + item.backdropPath;
      }
    });
    return response;
  }

  Future<CastDetail> getCastDetail(int castId) async {
    final url = BASE_URL_MOVIE_BY_CAST + castId.toString() + QUERY_API_KEY + API_KEY + _getLanguageQuery();
    final response = await executeGetRequest(url);
    return _convertCastDetailResponse(response);
  }

  CastDetail _convertCastDetailResponse(String jsonBody) {
    final responseMapData = jsonDecode(jsonBody);
    try {
      return _appendBaseUrlCastDetail(CastDetail.fromJson(responseMapData));
    } catch (e) {
      Logger.w('Parse data fail detail = $e');
    }
    return null;
  }

  CastDetail _appendBaseUrlCastDetail(CastDetail response) {
    if (response.profilePath != null) {
      response.profilePath = BASE_URL_MOVIE_IMAGE + response.profilePath;
    }
    return response;
  }

  Future<TrendingMediaResponse> getTrendingMedia(TrendingMediaType type) async {
    try {
      final url = BASE_URL_TRENDING + type.name + PATH_URL_TRENDING + QUERY_API_KEY + API_KEY + _getLanguageQuery();
      final response = await executeGetRequest(url);
      return _convertTrendingMediaResponse(response);
    } catch (e) {
      Logger.w('API Exception $e');
      throw e;
    }
  }

  TrendingMediaResponse _convertTrendingMediaResponse(String jsonBody) {
    final responseMapData = jsonDecode(jsonBody);
    return _appendBaseUrlTrendingMedia(TrendingMediaResponse.fromJson(responseMapData));
  }

  TrendingMediaResponse _appendBaseUrlTrendingMedia(TrendingMediaResponse response) {
    response.results.forEach((item) {
      if (item.posterPath != null) {
        item.posterPath = BASE_URL_MOVIE_IMAGE + item.posterPath;
      }
      if (item.backdropPath != null) {
        item.backdropPath = BASE_URL_MOVIE_IMAGE + item.backdropPath;
      }
    });
    return response;
  }

}