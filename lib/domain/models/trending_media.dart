import 'package:equatable/equatable.dart';

class TrendingMedia extends Equatable {
  final List<int>? genreIds;
  final String? originalLanguage;
  final String? originalTitle;
  final String? posterPath;
  final bool? video;
  final num? voteAverage;
  final int? id;
  final String? overview;
  final String? releaseDate;
  final int? voteCount;
  final String? title;
  final bool? adult;
  final String? backdropPath;
  final num? popularity;
  final String? mediaType;
  final String? name;

  const TrendingMedia({
    this.genreIds,
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.video,
    this.voteAverage,
    this.id,
    this.overview,
    this.releaseDate,
    this.voteCount,
    this.title,
    this.adult,
    this.backdropPath,
    this.popularity,
    this.mediaType,
    this.name,
  });

  @override
  List<Object?> get props => [
        genreIds,
        originalLanguage,
        originalTitle,
        posterPath,
        video,
        voteAverage,
        id,
        overview,
        releaseDate,
        voteCount,
        title,
        adult,
        backdropPath,
        popularity,
        mediaType,
        name,
      ];
}
