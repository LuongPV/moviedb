import '../../../domain/models/direction_response.dart' as domain;
import '../data_to_domain_mapper.dart';

class DirectionResponseMapper with DataToDomainMapper<data.DirectionResponse, domain.DirectionResponse> {
  @override
  domain.DirectionResponse convertToDomain(data.DirectionResponse inputType) {
    return domain.DirectionResponse(
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
