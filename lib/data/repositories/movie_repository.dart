import 'package:movie_db/data/models/cast_by_movie.dart';
import 'package:movie_db/data/models/cast_detail.dart';
import 'package:movie_db/data/models/movie_by_cast.dart';
import 'package:movie_db/data/models/movie_by_genre.dart';
import 'package:movie_db/data/models/movie_detail.dart';
import 'package:movie_db/data/models/movie_search.dart';
import 'package:movie_db/data/models/trending_media_response.dart';
import 'package:movie_db/data/models/trending_media_type.dart';
import 'package:movie_db/data/repositories/themoviedb_api.dart';

class MovieRepository {
  final _movieAPI = TheMovieDbAPI();

  Future<MovieSearchResponse> searchMovie(String title) {
    return _movieAPI.searchMovie(title);
  }

  Future<MovieDetail> getMovieDetail(int movieId) {
    return _movieAPI.getMovieDetail(movieId);
  }

  Future<MovieByGenreResponse> getMovieByGenre(int genreId) {
    return _movieAPI.getMovieByGenre(genreId);
  }

  Future<CastByMovieResponse> getCastByMovie(int movieId) {
    return _movieAPI.getCastByMovie(movieId);
  }

  Future<MovieByCastResponse> getMovieByCast(int castId) {
    return _movieAPI.getMovieByCast(castId);
  }

  Future<CastDetail> getCastDetail(int castId) {
    return _movieAPI.getCastDetail(castId);
  }

  Future<TrendingMediaResponse> getTrendingMedia(TrendingMediaType type) {
    return _movieAPI.getTrendingMedia(type);
  }
}
