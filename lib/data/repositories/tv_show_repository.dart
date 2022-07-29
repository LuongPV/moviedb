import '../apis/themoviedb_tv_show_api.dart';
import '../models/tv_show_detail.dart';

class TVShowRepository {
  final _theMovieDbAPI = TheMovieDbTVShowAPI();

  Future<TVShowDetail> getTVShowDetail(int tvShowId) {
    return _theMovieDbAPI.getTVShowDetail(tvShowId);
  }

}
