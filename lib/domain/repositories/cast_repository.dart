import 'package:moviedb/domain/models/cast.dart';

import '../models/cast_detail.dart';

abstract class CastRepository {
  Future<List<Cast>> getCastByMovie(int movieId);

  Future<List<Cast>> getCastByTVShow(int tvShowId);

  Future<CastDetail?> getCastDetail(int castId);
}
