enum TrendingMediaType {
  MOVIE,
  TV_SHOW,
  ALL
}

extension APIString on TrendingMediaType {

  String get name {
    switch (this) {
      case TrendingMediaType.MOVIE:
        return 'movie';
      case TrendingMediaType.TV_SHOW:
        return 'tv';
      case TrendingMediaType.ALL:
      default:
        return 'all';
    }
  }

}