import 'package:movie_db/data/apis/themoviedb_trending_api.dart';
import 'package:movie_db/data/models/trending_media_response.dart';
import 'package:movie_db/data/models/trending_media_type.dart';

class TrendingRepository {
  final _theMovieDbAPI = TheMovieDbTrendingAPI();

  Future<TrendingMediaResponse> getTrendingMedia(TrendingMediaType type) {
    return _theMovieDbAPI.getTrendingMedia(type);
  }
}
