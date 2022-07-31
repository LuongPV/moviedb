import '../../../domain/models/trending_media.dart' as domain;
import '../base_mapper.dart';
import 'trending_media.dart' as data;

class TrendingMediaMapper extends BaseMapper<data.TrendingMedia, domain.TrendingMedia> {
  @override
  domain.TrendingMedia convert(data.TrendingMedia inputType) {
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
