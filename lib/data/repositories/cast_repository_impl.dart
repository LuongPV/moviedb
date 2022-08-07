import 'package:moviedb/domain/models/cast.dart';

import '../../domain/models/cast_detail.dart';
import '../../domain/repositories/cast_repository.dart';
import '../apis/themoviedb_cast_api.dart';

class CastRepositoryImpl extends CastRepository {
  final TheMovieDbCastApi _theMovieDbApi;

  CastRepositoryImpl(this._theMovieDbApi);

  @override
  Future<List<Cast>> getCastByMovie(int movieId) {
    return _theMovieDbApi.getCastByMovie(movieId);
  }

  @override
  Future<List<Cast>> getCastByTVShow(int tvShowId) {
    return _theMovieDbApi.getCastByTVShow(tvShowId);
  }

  @override
  Future<CastDetail> getCastDetail(int castId) {
    return _theMovieDbApi.getCastDetail(castId);
  }
}
