import '../../../domain/models/trending_media.dart' as domain;
import '../data_to_domain_mapper.dart';
import 'trending_media.dart' as data;

class TrendingMediaMapper with DataToDomainMapper<data.TrendingMedia, domain.TrendingMedia> {
  @override
  domain.TrendingMedia convertToDomain(data.TrendingMedia inputType) {
    return domain.TrendingMedia(
      inputType.genreIds,
      inputType.originalLanguage,
      inputType.originalTitle,
      inputType.posterPath,
      inputType.video,
      inputType.voteAverage,
      inputType.id,
      inputType.overview,
      inputType.releaseDate,
      inputType.voteCount,
      inputType.title,
      inputType.adult,
      inputType.backdropPath,
      inputType.popularity,
      inputType.mediaType,
      inputType.name,
    );
  }
}
