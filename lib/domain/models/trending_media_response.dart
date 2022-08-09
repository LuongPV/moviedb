import 'trending_media.dart';

class TrendingMediaResponse {
  int? page;
  List<TrendingMedia>? results;
  int? totalPages;
  int? totalResults;

  TrendingMediaResponse(
      {this.page, this.results, this.totalPages, this.totalResults});

  @override
  String toString() {
    return 'TrendingMediaResponse{page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults}';
  }
}