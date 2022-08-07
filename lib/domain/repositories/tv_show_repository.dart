import '../models/tv_show_detail.dart';

abstract class TvShowRepository {
  Future<TVShowDetail> getTVShowDetail(int tvShowId);
}
