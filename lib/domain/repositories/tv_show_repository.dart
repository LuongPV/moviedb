import '../models/tv_show_detail.dart';

abstract class TVShowRepository {
  Future<TVShowDetail> getTVShowDetail(int tvShowId);
}
