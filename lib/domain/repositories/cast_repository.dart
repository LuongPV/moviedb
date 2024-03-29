import '../../data/models/cast_by_movie/cast_by_movie.dart';
import '../models/cast_by_tv_show.dart';
import '../models/cast_detail.dart';

abstract class CastRepository {
  Future<CastByMovieResponse?> getCastByMovie(int movieId);

  Future<CastByTVShow?> getCastByTVShow(int tvShowId);

  Future<CastDetail?> getCastDetail(int castId);
}
