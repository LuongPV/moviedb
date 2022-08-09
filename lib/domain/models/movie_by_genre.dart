import 'movie_general.dart';

class MovieByGenreResponse {
  int? page;
  List<MovieGeneral>? results;
  int? totalPages;
  int? totalResults;

  MovieByGenreResponse({this.page, this.results, this.totalPages, this.totalResults});

  @override
  String toString() {
    return 'MovieByGenreResponse{page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults}';
  }
}