import '../../../domain/models/cast_by_movie.dart';
import '../base_mapper.dart';
import '../cast/cast_mapper.dart';
import 'cast_by_movie.dart';

class CastByMovieMapper extends BaseMapper<CastByMovieResponse, CastByMovie> {
  @override
  CastByMovie convert(CastByMovieResponse inputType) {
    return CastByMovie(
      inputType.id,
      CastMapper().convertList(inputType.cast),
    );
  }
}
