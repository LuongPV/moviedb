import 'dart:io';

import 'package:sprintf/sprintf.dart';

import '../../utils/logger/logger.dart';
import '../constants.dart';
import '../models/movie_by_cast.dart';
import '../models/movie_by_genre.dart';
import '../models/movie_detail.dart';
import '../models/movie_search.dart';
import 'base_themoviedb_api.dart';

class TheMovieDbMovieAPI extends BaseTheMovieDbAPI {

  Future<MovieSearchResponse> searchMovie(String title) async {
    try {
      final url = sprintf(URL_MOVIE_SEARCH, [title, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = MovieSearchResponse.fromJson(jsonMap);
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

  Future<MovieDetail> getMovieDetail(int movieId) async {
    try {
      final url = sprintf(URL_MOVIE_DETAIL, [movieId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = MovieDetail.fromJson(jsonMap);
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

  Future<MovieByGenreResponse> getMovieByGenre(int genreId) async {
    try {
      final url = sprintf(URL_MOVIE_BY_GENRE, [genreId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = MovieByGenreResponse.fromJson(jsonMap);
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

  Future<MovieByCastResponse> getMovieByCast(int castId) async {
    try {
      final url = sprintf(URL_MOVIE_BY_CAST, [castId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = MovieByCastResponse.fromJson(jsonMap);
        response.cast.forEach((item) {
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