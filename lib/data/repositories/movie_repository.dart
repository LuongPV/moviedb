import 'package:movie_db/data/models/movie_detail.dart';
import 'package:movie_db/data/models/movie_search.dart';
import 'package:movie_db/data/repositories/themoviedb_api.dart';

class MovieRepository {
  final _movieAPI = TheMovieDbAPI();

  Future<MovieSearchResponse> searchMovie(String title) {
    return _movieAPI.searchMovie(title);
  }

  Future<MovieDetail> getMovieDetail(int movieId) {
    return _movieAPI.getMovieDetail(movieId);
  }
}
