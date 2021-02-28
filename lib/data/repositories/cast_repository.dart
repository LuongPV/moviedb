import 'package:movie_db/data/apis/themoviedb_cast_api.dart';
import 'package:movie_db/data/models/cast_by_movie.dart';
import 'package:movie_db/data/models/cast_by_tv_show.dart';
import 'package:movie_db/data/models/cast_detail.dart';

class CastRepository {
  final _theMovieDbAPI = TheMovieDbCastAPI();

  Future<CastByMovieResponse> getCastByMovie(int movieId) {
    return _theMovieDbAPI.getCastByMovie(movieId);
  }

  Future<CastByTVShowResponse> getCastByTVShow(int tvShowId) {
    return _theMovieDbAPI.getCastByTVShow(tvShowId);
  }

  Future<CastDetail> getCastDetail(int castId) {
    return _theMovieDbAPI.getCastDetail(castId);
  }
}
