import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final BelongsToCollection? belongsToCollection;
  final int? budget;
  final List<Genres> genres;
  final String? homepage;
  final int? id;
  final String? imdbId;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompanies>? productionCompanies;
  final List<ProductionCountries>? productionCountries;
  final String? releaseDate;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguages>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  const MovieDetail(
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  );

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        belongsToCollection,
        budget,
        genres,
        homepage,
        id,
        imdbId,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        productionCountries,
        releaseDate,
        revenue,
        runtime,
        spokenLanguages,
        status,
        tagline,
        title,
        video,
        voteAverage,
        voteCount,
      ];
}

class BelongsToCollection {
  int? id;
  String? name;
  String? posterPath;
  String? backdropPath;

  BelongsToCollection(id, name, posterPath, backdropPath);
}

class Genres {
  int? id;
  String? name;

  Genres(id, name);
}

class ProductionCompanies {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompanies(id, logoPath, name, originCountry);
}

class ProductionCountries {
  String? iso31661;
  String? name;

  ProductionCountries(iso31661, name);
}

class SpokenLanguages {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguages(englishName, iso6391, name);
}
