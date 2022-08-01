import '../../../domain/models/movie_detail.dart' as domain;
import '../base_to_domain_mapper.dart';
import 'movie_detail.dart' as data;

class CastByMovieMapper with DataToDomainMapper<data.MovieDetail, domain.MovieDetail> {
  @override
  domain.MovieDetail convertToDomain(data.MovieDetail inputType) {
    return domain.MovieDetail(
      inputType.adult,
      inputType.backdropPath,
      _convertBelongsToCollection(inputType.belongsToCollection),
      inputType.budget,
      _convertGenres(inputType.genres),
      inputType.homepage,
      inputType.id,
      inputType.imdbId,
      inputType.originalLanguage,
      inputType.originalTitle,
      inputType.overview,
      inputType.popularity,
      inputType.posterPath,
      _convertProductionCompanies(inputType.productionCompanies),
      _convertProductionCountries(inputType.productionCountries),
      inputType.releaseDate,
      inputType.revenue,
      inputType.runtime,
      _convertSpokenLanguages(inputType.spokenLanguages),
      inputType.status,
      inputType.tagline,
      inputType.title,
      inputType.video,
      inputType.voteAverage,
      inputType.voteCount,
    );
  }

  domain.BelongsToCollection? _convertBelongsToCollection(data.BelongsToCollection? inputType) {
    if (inputType == null) {
      return null;
    }
    return domain.BelongsToCollection(
      inputType.id,
      inputType.name,
      inputType.posterPath,
      inputType.backdropPath,
    );
  }

  List<domain.Genres>? _convertGenres(List<data.Genres>? inputType) {
    if (inputType == null) {
      return null;
    }
    return inputType.map((e) => domain.Genres(
      e.id,
      e.name,
    )).toList();
  }

    List<domain.ProductionCompanies>? _convertProductionCompanies(List<data.ProductionCompanies>? inputType) {
    if (inputType == null) {
      return null;
    }
    return inputType.map((e) => domain.ProductionCompanies(
      e.id, 
      e.logoPath, 
      e.name, 
      e.originCountry,
    )).toList();
  }

    List<domain.ProductionCountries>? _convertProductionCountries(List<data.ProductionCountries>? inputType) {
    if (inputType == null) {
      return null;
    }
    return inputType.map((e) => domain.ProductionCountries(
      e.iso31661, 
      e.name,
    )).toList();
  }

    List<domain.SpokenLanguages>? _convertSpokenLanguages(List<data.SpokenLanguages>? inputType) {
    if (inputType == null) {
      return null;
    }
    return inputType.map((e) => domain.SpokenLanguages(
      e.englishName, 
      e.iso6391, 
      e.name,
    )).toList();
  }
}
