import 'package:movie_db/data/apis/themoviedb_movie_api.dart';
import 'package:movie_db/data/models/movie_by_cast.dart';
import 'package:movie_db/data/models/movie_by_genre.dart';
import 'package:movie_db/data/models/movie_detail.dart';
import 'package:movie_db/data/models/movie_search.dart';

class MovieRepository {
  final _theMovieDbAPI = TheMovieDbMovieAPI();

  Future<MovieSearchResponse> searchMovie(String title) {
    return _theMovieDbAPI.searchMovie(title);
  }

  Future<MovieDetail> getMovieDetail(int movieId) {
    return _theMovieDbAPI.getMovieDetail(movieId);
  }

  Future<MovieByGenreResponse> getMovieByGenre(int genreId) {
    return _theMovieDbAPI.getMovieByGenre(genreId);
  }

  Future<MovieByCastResponse> getMovieByCast(int castId) {
    return _theMovieDbAPI.getMovieByCast(castId);
  }
}
