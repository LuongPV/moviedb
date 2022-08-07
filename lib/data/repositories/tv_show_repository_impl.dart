import '../../domain/repositories/tv_show_repository.dart';
import '../apis/themoviedb_tv_show_api.dart';
import '../models/tv_show_detail.dart';

class TvShowRepositoryImpl extends TvShowRepository {
  final TheMovieDbTVShowApi _theMovieDbApi;

  @override
  Future<TVShowDetail> getTVShowDetail(int tvShowId) {
    return _theMovieDbApi.getTVShowDetail(tvShowId);
  }

}
