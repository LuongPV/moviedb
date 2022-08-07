import '../../domain/models/trending_media_type.dart';

extension ApiString on TrendingMediaType {
  String get name {
    switch (this) {
      case TrendingMediaType.movie:
        return 'movie';
      case TrendingMediaType.tvShow:
        return 'tv';
      case TrendingMediaType.all:
      default:
        return 'all';
    }
  }
}
