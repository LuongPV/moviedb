import '../../../domain/models/cast_by_movie.dart';
import '../base_to_domain_mapper.dart';
import '../cast/cast_mapper.dart';
import 'cast_by_movie.dart';

class CastByMovieMapper with DataToDomainMapper<CastByMovieResponse, CastByMovie> {
  @override
  CastByMovie convertToDomain(CastByMovieResponse inputType) {
    return CastByMovie(
      inputType.id,
      CastMapper().convertListToDomain(inputType.cast),
    );
  }
}
