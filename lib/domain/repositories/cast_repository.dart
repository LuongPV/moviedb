import '../apis/themoviedb_cast_api.dart';
import '../models/cast_by_movie.dart';
import '../models/cast_by_tv_show.dart';
import '../models/cast_detail.dart';

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
