import '../../../domain/models/cast_detail.dart' as domain;
import '../data_to_domain_mapper.dart';
import 'cast_detail.dart' as data;

class CastDetailMapper with DataToDomainMapper<data.CastDetail, domain.CastDetail> {
  @override
  domain.CastDetail convertToDomain(data.CastDetail inputType) {
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
