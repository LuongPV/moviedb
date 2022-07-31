class TrendingMedia {
  List<int>? genreIds;
  String? originalLanguage;
  String? originalTitle;
  String? posterPath;
  bool? video;
  num? voteAverage;
  int? id;
  String? overview;
  String? releaseDate;
  int? voteCount;
  String? title;
  bool? adult;
  String? backdropPath;
  num? popularity;
  String? mediaType;
  String? name;

  TrendingMedia.fromJson(Map<String, dynamic> json) {
    genreIds = json['genre_ids'].cast<int>();
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    posterPath = json['poster_path'];
    video = json['video'];
    voteAverage = json['vote_average'];
    id = json['id'];
    overview = json['overview'];
    releaseDate = json['release_date'];
    voteCount = json['vote_count'];
    title = json['title'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    popularity = json['popularity'];
    mediaType = json['media_type'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['genre_ids'] = genreIds;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['poster_path'] = posterPath;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['id'] = id;
    data['overview'] = overview;
    data['release_date'] = releaseDate;
    data['vote_count'] = voteCount;
    data['title'] = title;
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['popularity'] = popularity;
    data['media_type'] = mediaType;
    data['name'] = name;
    return data;
  }
}
