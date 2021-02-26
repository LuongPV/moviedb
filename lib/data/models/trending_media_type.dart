enum TrendingMediaType {
  MOVIE,
  TV_SHOW
}

extension APIString on TrendingMediaType {

  String get name {
    switch (this) {
      case TrendingMediaType.MOVIE:
        return 'movie';
      case TrendingMediaType.TV_SHOW:
        return 'tv';
      default:
        return 'all';
    }
  }

}