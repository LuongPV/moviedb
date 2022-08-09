class TvShowDetail {
  String? backdropPath;
  List<Genre>? genres;
  String? homepage;
  int? id;
  String? name;
  String? overview;
  String? posterPath;
  num? voteAverage;
  String? lastAirDate;

  TvShowDetail(
      {this.backdropPath,
        this.genres,
        this.homepage,
        this.id,
        this.name,
        this.overview,
        this.posterPath,
        this.voteAverage,
        this.lastAirDate});

}

class Genre {
  int? id;
  String? name;

  Genre({this.id, this.name});

}