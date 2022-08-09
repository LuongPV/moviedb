import 'package:moviedb/data/models/movie_general/movie_general_mapper.dart';

import '../../../domain/models/movie_by_genre.dart' as domain;
import '../data_to_domain_mapper.dart';
import 'movie_by_genre.dart' as data;

class MovieByGenreResponseMapper
    with
        DataToDomainMapper<data.MovieByGenreResponse,
            domain.MovieByGenreResponse> {
  @override
  domain.MovieByGenreResponse convertToDomain(
      data.MovieByGenreResponse? inputType) {
    return domain.MovieByGenreResponse(
      page: inputType?.page,
      results: MovieGeneralMapper().convertListToDomain(inputType?.results),
      totalPages: inputType?.totalPages,
      totalResults: inputType?.totalResults,
    );
  }
}
