import 'trending_media/trending_media.dart';

class TrendingMediaResponse {
  int page;
  List<TrendingMedia> results;
  int totalPages;
  int totalResults;

  TrendingMediaResponse(
      {this.page, this.results, this.totalPages, this.totalResults});

  TrendingMediaResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = new List<TrendingMedia>();
      json['results'].forEach((v) {
        results.add(new TrendingMedia.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }

  @override
  String toString() {
    return 'TrendingMediaResponse{page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults}';
  }
}