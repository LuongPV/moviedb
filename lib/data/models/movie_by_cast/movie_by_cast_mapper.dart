import 'package:moviedb/data/models/movie_general/movie_general_mapper.dart';

import '../../../domain/models/movie_by_cast.dart' as domain;
import '../data_to_domain_mapper.dart';
import 'movie_by_cast.dart' as data;

class MovieByCastResponseMapper
    with
        DataToDomainMapper<data.MovieByCastResponse,
            domain.MovieByCastResponse> {
  @override
  domain.MovieByCastResponse convertToDomain(
      data.MovieByCastResponse? inputType) {
    return domain.MovieByCastResponse(
      cast: MovieGeneralMapper().convertListToDomain(inputType?.cast),
      id: inputType?.id,
    );
  }
}
