import '../../../domain/models/movie_general.dart' as domain;
import '../data_to_domain_mapper.dart';
import 'movie_general.dart' as data;

class MovieGeneralMapper
    with DataToDomainMapper<data.MovieGeneral, domain.MovieGeneral> {
  @override
  domain.MovieGeneral convertToDomain(data.MovieGeneral inputType) {
    return domain.MovieGeneral(
        adult: inputType.adult,
        backdropPath: inputType.backdropPath,
        genreIds: inputType.genreIds,
        id: inputType.id,
        originalLanguage: inputType.originalLanguage,
        originalTitle: inputType.originalTitle,
        overview: inputType.overview,
        popularity: inputType.popularity,
        posterPath: inputType.posterPath,
        releaseDate: inputType.releaseDate,
        title: inputType.title,
        video: inputType.video,
        voteAverage: inputType.voteAverage,
        voteCount: inputType.voteCount,
        name: inputType.name);
  }
}
