import 'package:moviedb/domain/models/cast.dart';

import '../models/cast_by_tv_show.dart';
import '../models/cast_detail.dart';

abstract class CastRepository {
  Future<List<Cast>> getCastByMovie(int movieId);

  Future<CastByTVShow?> getCastByTVShow(int tvShowId);

  Future<CastDetail?> getCastDetail(int castId);
}
