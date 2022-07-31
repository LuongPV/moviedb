import '../../../domain/models/cast.dart' as cast_domain;
import '../base_mapper.dart';
import 'cast_data.dart' as cast_data;

class CastMapper extends BaseMapper<cast_data.Cast, cast_domain.Cast> {
  @override
  cast_domain.Cast convert(cast_data.Cast inputType) {
    return cast_domain.Cast(
      inputType.adult,
      inputType.gender,
      inputType.id,
      inputType.knownForDepartment,
      inputType.name,
      inputType.originalName,
      inputType.popularity,
      inputType.profilePath,
      inputType.castId,
      inputType.character,
      inputType.creditId,
      inputType.order,
    );
  }
}
