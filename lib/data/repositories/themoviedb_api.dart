import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_db/data/models/search_movie.dart';
import 'package:movie_db/utils/logger/logger.dart';

import '../constants.dart';

class TheMovieDbAPI {

  Future<SearchMovieResponse> searchMovie(String title) async {
    final query = BASE_URL_MOVIE_SEARCH + QUERY_API_KEY + API_KEY + QUERY_MOVIE_TITLE + title;
    final encodedQuery = Uri.encodeFull(query);
    Logger.d('encodedQuery = $encodedQuery');
    final response = await http.get(encodedQuery);
    Logger.d('data = ${response.body}');
    if (response.statusCode == 200) {
      return _convertJsonResponse(response.body);
    }
    return null;
  }

  SearchMovieResponse _convertJsonResponse(String jsonBody) {
    final responseMapData = jsonDecode(jsonBody);
    try {
      return _appendBaseUrl(SearchMovieResponse.fromJson(responseMapData));
    } catch (e) {
      Logger.w('Parse search data fail detail = $e');
    }
    return null;
  }

}

SearchMovieResponse _appendBaseUrl(SearchMovieResponse searchMovieResponse) {
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