import '../models/cast_by_movie/cast_by_movie.dart';
import '../models/cast_by_tv_show/cast_by_tv_show.dart';
import '../models/cast_detail/cast_detail.dart';
import 'base_themoviedb_api.dart';

abstract class TheMovieDbCastApi extends BaseTheMovieDbApi {
  Future<CastByMovieResponse?> getCastByMovie(int movieId);

  Future<CastByTVShowResponse?> getCastByTVShow(int movieId);

  Future<CastDetail?> getCastDetail(int castId);
}
