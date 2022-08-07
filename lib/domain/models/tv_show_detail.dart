class TvShowDetail {
  String backdropPath;
  List<Genre> genres;
  String homepage;
  int id;
  String name;
  String overview;
  String posterPath;
  num voteAverage;
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

  TvShowDetail.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    if (json['genres'] != null) {
      genres = new List<Genre>();
      json['genres'].forEach((v) {
        genres.add(new Genre.fromJson(v));
      });
    }
    homepage = json['homepage'];
    id = json['id'];
    name = json['name'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    voteAverage = json['vote_average'];
    lastAirDate = json['last_air_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backdrop_path'] = this.backdropPath;
    if (this.genres != null) {
      data['genres'] = this.genres.map((v) => v.toJson()).toList();
    }
    data['homepage'] = this.homepage;
    data['id'] = this.id;
    data['name'] = this.name;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    data['vote_average'] = this.voteAverage;
    data['last_air_date'] = this.lastAirDate;
    return data;
  }
}

class Genre {
  int id;
  String name;

  Genre({this.id, this.name});

  Genre.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}