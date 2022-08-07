import '../../domain/models/movie_detail.dart';
import '../../domain/repositories/movie_repository.dart';
import '../apis/themoviedb_movie_api.dart';
import '../models/movie_by_cast.dart';
import '../models/movie_by_genre.dart';
import '../models/movie_search.dart';

class MovieRepositoryImpl extends MovieRepository {
  final TheMovieDbMovieApi _theMovieDbApi;

  MovieRepositoryImpl(this._theMovieDbApi);

  @override
  Future<MovieSearchResponse> searchMovie(String title) {
    return _theMovieDbApi.searchMovie(title);
  }

  @override
  Future<MovieDetail> getMovieDetail(int movieId) {
    return _theMovieDbApi.getMovieDetail(movieId);
  }

  @override
  Future<MovieByGenreResponse> getMovieByGenre(int genreId) {
    return _theMovieDbApi.getMovieByGenre(genreId);
  }

  @override
  Future<MovieByCastResponse> getMovieByCast(int castId) {
    return _theMovieDbApi.getMovieByCast(castId);
  }
}
