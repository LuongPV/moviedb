import 'package:moviedb/domain/models/cast.dart';

import '../../domain/repositories/cast_repository.dart';
import '../apis/themoviedb_cast_api.dart';
import '../models/cast_by_tv_show/cast_by_tv_show.dart';
import '../models/cast_detail/cast_detail.dart';

class CastRepositoryImpl extends CastRepository {
  final TheMovieDbCastApi _theMovieDbApi;

  CastRepositoryImpl(this._theMovieDbApi);

  @override
  Future<List<Cast>> getCastByMovie(int movieId) {
    return _theMovieDbApi.getCastByMovie(movieId);
  }

  @override
  Future<CastByTVShowResponse> getCastByTVShow(int tvShowId) {
    return _theMovieDbApi.getCastByTVShow(tvShowId);
  }

  @override
  Future<CastDetail> getCastDetail(int castId) {
    return _theMovieDbApi.getCastDetail(castId);
  }
}
