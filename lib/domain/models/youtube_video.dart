class TheMovieDBYoutubeVideo {
  String? id;
  String? iso6391;
  String? iso31661;
  String? key;
  String? name;
  String? site;
  int? size;
  String? type;

  TheMovieDBYoutubeVideo(
      {this.id,
      this.iso6391,
      this.iso31661,
      this.key,
      this.name,
      this.site,
      this.size,
      this.type});

  @override
  String toString() {
    return 'TheMovieDBYoutubeVideo{id: $id, iso6391: $iso6391, iso31661: $iso31661, key: $key, name: $name, site: $site, size: $size, type: $type}';
  }
}
