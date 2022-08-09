import '../../../domain/models/trending_media.dart' as domain;
import '../data_to_domain_mapper.dart';
import 'trending_media.dart' as data;

class TrendingMediaMapper with DataToDomainMapper<data.TrendingMedia, domain.TrendingMedia> {
  @override
  domain.TrendingMedia convertToDomain(data.TrendingMedia inputType) {
    return domain.TrendingMedia(
      genreIds: inputType.genreIds,
      originalLanguage: inputType.originalLanguage,
      originalTitle: inputType.originalTitle,
      posterPath: inputType.posterPath,
      video: inputType.video,
      voteAverage: inputType.voteAverage,
      id: inputType.id,
      overview: inputType.overview,
      releaseDate: inputType.releaseDate,
      voteCount: inputType.voteCount,
      title: inputType.title,
      adult: inputType.adult,
      backdropPath: inputType.backdropPath,
      popularity: inputType.popularity,
      mediaType: inputType.mediaType,
      name: inputType.name,
    );
  }
}
