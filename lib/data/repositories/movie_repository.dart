import 'package:movie_db/data/models/search_movie.dart';
import 'package:movie_db/data/repositories/themoviedb_api.dart';

class MovieRepository {
  final _movieAPI = TheMovieDbAPI();

  Future<SearchMovieResponse> searchMovie(String title) {
    return _movieAPI.searchMovie(title);
  }
}
