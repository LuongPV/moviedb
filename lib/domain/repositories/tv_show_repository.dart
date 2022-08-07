import '../models/tv_show_detail.dart';

abstract class TvShowRepository {
  Future<TvShowDetail> getTvShowDetail(int tvShowId);
}
