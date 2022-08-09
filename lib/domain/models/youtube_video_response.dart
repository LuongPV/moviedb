class YoutubeVideoResponse {
  List<YoutubeVideo>? items;
  PageInfo? pageInfo;

  YoutubeVideoResponse({this.items, this.pageInfo});

}

class YoutubeVideo {
  String? id;
  YoutubeVideoInfo? snippet;

  YoutubeVideo({this.id, this.snippet});

}

class YoutubeVideoInfo {
  String? title;
  Thumbnails? thumbnails;
  Localized? localized;

  YoutubeVideoInfo({this.title, this.thumbnails, this.localized});

}

class Thumbnails {
  ThumbnailInfo? standard;
  ThumbnailInfo? high;
  ThumbnailInfo? medium;
  ThumbnailInfo? defaultT;

  Thumbnails({this.standard, this.high, this.medium, this.defaultT});

}

class ThumbnailInfo {
  String? url;
  int? width;
  int? height;

  ThumbnailInfo({this.url, this.width, this.height});

}

class Localized {
  String? title;
  String? description;

  Localized({this.title, this.description});

}

class PageInfo {
  int? totalResults;
  int? resultsPerPage;

  PageInfo({this.totalResults, this.resultsPerPage});

}
