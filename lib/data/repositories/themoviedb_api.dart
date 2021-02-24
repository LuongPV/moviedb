import 'dart:convert';
import 'dart:io';

import 'package:movie_db/data/models/movie_by_genre.dart';
import 'package:movie_db/data/models/movie_detail.dart';
import 'package:movie_db/data/models/movie_search.dart';
import 'package:movie_db/data/repositories/base_api.dart';
import 'package:movie_db/utils/logger/logger.dart';

import '../constants.dart';

class TheMovieDbAPI extends BaseAPI {

  Future<MovieSearchResponse> searchMovie(String title) async {
    final url = BASE_URL_MOVIE_SEARCH + QUERY_API_KEY + API_KEY + _getLanguageQuery() +
        QUERY_MOVIE_TITLE + title;
    final response = await executeGetRequest(url);
    return _convertMovieSearchResponse(response);
  }

  MovieSearchResponse _convertMovieSearchResponse(String jsonBody) {
    final responseMapData = jsonDecode(jsonBody);
    try {
      return _appendBaseUrlMovieSearch(MovieSearchResponse.fromJson(responseMapData));
    } catch (e) {
      Logger.w('Parse search data fail detail = $e');
    }
    return null;
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
}