class TrendingMedia {
  List<int> genreIds;
  String originalLanguage;
  String originalTitle;
  String posterPath;
  bool video;
  num voteAverage;
  int id;
  String overview;
  String releaseDate;
  int voteCount;
  String title;
  bool adult;
  String backdropPath;
  num popularity;
  String mediaType;
  String name;

  TrendingMedia(
      {this.genreIds,
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
        this.name});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['genre_ids'] = this.genreIds;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['poster_path'] = this.posterPath;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['id'] = this.id;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    data['vote_count'] = this.voteCount;
    data['title'] = this.title;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['popularity'] = this.popularity;
    data['media_type'] = this.mediaType;
    data['name'] = this.name;
    return data;
  }

  @override
  String toString() {
    return 'TrendingMedia{genreIds: $genreIds, originalLanguage: $originalLanguage, originalTitle: $originalTitle, posterPath: $posterPath, video: $video, voteAverage: $voteAverage, id: $id, overview: $overview, releaseDate: $releaseDate, voteCount: $voteCount, title: $title, adult: $adult, backdropPath: $backdropPath, popularity: $popularity, mediaType: $mediaType}';
  }
}