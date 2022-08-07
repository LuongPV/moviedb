import '../../domain/models/tv_show_detail.dart';
import '../../domain/repositories/tv_show_repository.dart';
import '../apis/themoviedb_tv_show_api.dart';

class TvShowRepositoryImpl extends TvShowRepository {
  final TheMovieDbTVShowApi _theMovieDbApi;

  TvShowRepositoryImpl(this._theMovieDbApi);

  @override
  Future<TvShowDetail> getTvShowDetail(int tvShowId) {
    return _theMovieDbApi.getTVShowDetail(tvShowId);
  }
}
