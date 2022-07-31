import '../models/trending_media_response.dart';
import '../models/trending_media_type.dart';

abstract class TrendingRepository {
  Future<TrendingMediaResponse> getTrendingMedia(TrendingMediaType type);
}
