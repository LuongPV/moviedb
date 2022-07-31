import '../models/movie_by_cast.dart';
import '../models/movie_by_genre.dart';
import '../models/movie_detail.dart';
import '../models/movie_search.dart';

abstract class MovieRepository {
  Future<MovieSearchResponse> searchMovie(String title);

  Future<MovieDetail> getMovieDetail(int movieId);

  Future<MovieByGenreResponse> getMovieByGenre(int genreId);

  Future<MovieByCastResponse> getMovieByCast(int castId);
}
