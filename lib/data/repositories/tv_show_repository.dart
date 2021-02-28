import 'package:movie_db/data/apis/themoviedb_tv_show_api.dart';
import 'package:movie_db/data/models/tv_show_detail.dart';

class TVShowRepository {
  final _theMovieDbAPI = TheMovieDbTVShowAPI();

  Future<TVShowDetail> getTVShowDetail(int tvShowId) {
    return _theMovieDbAPI.getTVShowDetail(tvShowId);
  }

}
