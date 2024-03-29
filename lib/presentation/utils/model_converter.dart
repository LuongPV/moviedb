import '../data/models/movie_general.dart';
import '../data/models/trending_media.dart';

extension Media on List<MovieGeneral> {
  List<TrendingMedia> toMedia() {
    return this.map((movieGeneral) => TrendingMedia(
      id: movieGeneral.id,
      backdropPath: movieGeneral.backdropPath,
      posterPath: movieGeneral.posterPath,
      title: movieGeneral.title,
      name: movieGeneral.name,
      overview: movieGeneral.overview,
      voteCount: movieGeneral.voteCount,
      releaseDate: movieGeneral.releaseDate,
    )).toList();
  }
}