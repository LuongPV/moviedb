import 'movie_general.dart';

class MovieSearchResponse {
  int? page;
  List<MovieGeneral>? results;
  int? totalPages;
  int? totalResults;

  MovieSearchResponse({this.page, this.results, this.totalPages, this.totalResults});

  @override
  String toString() {
    return 'MovieSearchResponse{page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults}';
  }
}