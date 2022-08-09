class YoutubeVideoResponse {
  List<YoutubeVideo>? items;
  PageInfo? pageInfo;

  YoutubeVideoResponse({this.items, this.pageInfo});

  YoutubeVideoResponse.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(new YoutubeVideo.fromJson(v));
      });
    }
    pageInfo = json['pageInfo'] != null
        ? new PageInfo.fromJson(json['pageInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items?.map((v) => v.toJson()).toList();
    }
    if (this.pageInfo != null) {
      data['pageInfo'] = this.pageInfo?.toJson();
    }
    return data;
  }
}

class YoutubeVideo {
  String? id;
  YoutubeVideoInfo? snippet;

  YoutubeVideo({this.id, this.snippet});

  YoutubeVideo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    snippet = json['snippet'] != null
        ? new YoutubeVideoInfo.fromJson(json['snippet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.snippet != null) {
      data['snippet'] = this.snippet?.toJson();
    }
    return data;
  }
}

class YoutubeVideoInfo {
  String? title;
  Thumbnails? thumbnails;
  Localized? localized;

  YoutubeVideoInfo({this.title, this.thumbnails, this.localized});

  YoutubeVideoInfo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumbnails = json['thumbnails'] != null
        ? new Thumbnails.fromJson(json['thumbnails'])
        : null;
    localized = json['localized'] != null
        ? new Localized.fromJson(json['localized'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.thumbnails != null) {
      data['thumbnails'] = this.thumbnails?.toJson();
    }
    if (this.localized != null) {
      data['localized'] = this.localized?.toJson();
    }
    return data;
  }
}

class Thumbnails {
  ThumbnailInfo? standard;
  ThumbnailInfo? high;
  ThumbnailInfo? medium;
  ThumbnailInfo? defaultT;

  Thumbnails({this.standard, this.high, this.medium, this.defaultT});

  Thumbnails.fromJson(Map<String, dynamic> json) {
    standard = json['standard'] != null
        ? new ThumbnailInfo.fromJson(json['standard'])
        : null;
    standard =
        json['high'] != null ? new ThumbnailInfo.fromJson(json['high']) : null;
    standard = json['medium'] != null
        ? new ThumbnailInfo.fromJson(json['medium'])
        : null;
    defaultT = json['default'] != null
        ? new ThumbnailInfo.fromJson(json['default'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.standard != null) {
      data['standard'] = this.standard?.toJson();
    }
    return data;
  }

  ThumbnailInfo? getThumbnailInfo() {
    if (standard != null) return standard;
    if (high != null) return high;
    if (medium != null) return medium;
    return defaultT;
  }
}

class ThumbnailInfo {
  String? url;
  int? width;
  int? height;

  ThumbnailInfo({this.url, this.width, this.height});

  ThumbnailInfo.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Localized {
  String? title;
  String? description;

  Localized({this.title, this.description});

  Localized.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}

class PageInfo {
  int? totalResults;
  int? resultsPerPage;

  PageInfo({this.totalResults, this.resultsPerPage});

  PageInfo.fromJson(Map<String, dynamic> json) {
    totalResults = json['totalResults'];
    resultsPerPage = json['resultsPerPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalResults'] = this.totalResults;
    data['resultsPerPage'] = this.resultsPerPage;
    return data;
  }
}
