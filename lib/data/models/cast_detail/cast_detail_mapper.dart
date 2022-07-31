import '../../../domain/models/cast_detail.dart' as domain;
import '../base_mapper.dart';
import 'cast_detail.dart' as data;

class CastDetailMapper extends BaseMapper<data.CastDetail, domain.CastDetail> {
  @override
  domain.CastDetail convert(data.CastDetail inputType) {
    return domain.CastDetail(
      inputType.adult,
      inputType.alsoKnownAs,
      inputType.biography,
      inputType.birthday,
      inputType.deathday,
      inputType.gender,
      inputType.homepage,
      inputType.id,
      inputType.imdbId,
      inputType.knownForDepartment,
      inputType.name,
      inputType.placeOfBirth,
      inputType.popularity,
      inputType.profilePath,
    );
  }
}
