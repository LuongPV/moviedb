import '../../domain/repositories/trending_repository.dart';
import '../apis/themoviedb_trending_api.dart';
import '../models/trending_media_response.dart';
import '../models/trending_media_type.dart';

class TrendingRepositoryImpl extends TrendingRepository {
  final TheMovieDbTrendingApi _theMovieDbApi;

  TrendingRepositoryImpl(this._theMovieDbApi);

  @override
  Future<TrendingMediaResponse> getTrendingMedia(TrendingMediaType type) {
    return _theMovieDbApi.getTrendingMedia(type);
  }
}
