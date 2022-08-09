import 'movie_general.dart';

class MovieSearchResponse {
  int? page;
  List<MovieGeneral>? results;
  int? totalPages;
  int? totalResults;

  MovieSearchResponse({this.page, this.results, this.totalPages, this.totalResults});

  MovieSearchResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(new MovieGeneral.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results?.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }

  @override
  String toString() {
    return 'MovieSearchResponse{page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults}';
  }
}