import 'dart:io';

import 'package:sprintf/sprintf.dart';

import '../../presentation/utils/logger/logger.dart';
import '../constants.dart';
import '../models/movie_by_cast/movie_by_cast.dart';
import '../models/movie_by_genre/movie_by_genre.dart';
import '../models/movie_detail/movie_detail.dart';
import '../models/movie_search.dart';
import 'themoviedb_movie_api.dart';

class TheMovieDbMovieApiImpl extends TheMovieDbMovieApi {
  @override
  Future<MovieSearchResponse?> searchMovie(String title) async {
    try {
      final url = sprintf(urlMovieSearch, [title, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = MovieSearchResponse.fromJson(jsonMap);
        if (response.results != null) {
          for (var item in response.results!) {
            item.posterPath = appendImageUrl(item.posterPath);
            item.backdropPath = appendImageUrl(item.backdropPath);
          }
        }
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      rethrow;
    }
  }

  @override
  Future<MovieDetail?> getMovieDetail(int movieId) async {
    try {
      final url = sprintf(urlMovieDetail, [movieId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = MovieDetail.fromJson(jsonMap);
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

  @override
  Future<MovieByGenreResponse?> getMovieByGenre(int genreId) async {
    try {
      final url = sprintf(urlMovieByGenre, [genreId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = MovieByGenreResponse.fromJson(jsonMap);
        if (response.results != null) {
          for (var item in response.results!) {
            item.posterPath = appendImageUrl(item.posterPath);
            item.backdropPath = appendImageUrl(item.backdropPath);
          }
        }
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      rethrow;
    }
  }

  @override
  Future<MovieByCastResponse?> getMovieByCast(int castId) async {
    try {
      final url = sprintf(urlMovieByCast, [castId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = MovieByCastResponse.fromJson(jsonMap);
        if (response.cast != null) {
          for (var item in response.cast!) {
            item.posterPath = appendImageUrl(item.posterPath);
            item.backdropPath = appendImageUrl(item.backdropPath);
          }
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
