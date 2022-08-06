import '../models/trending_media_response.dart';
import '../models/trending_media_type.dart';
import 'base_themoviedb_api.dart';

abstract class TheMovieDbTrendingApi extends BaseTheMovieDbApi {
  Future<TrendingMediaResponse?> getTrendingMedia(TrendingMediaType type);
}
