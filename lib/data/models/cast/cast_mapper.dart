import '../../../domain/models/cast.dart' as domain;
import '../data_to_domain_mapper.dart';
import 'cast.dart' as data;

class CastMapper with DataToDomainMapper<data.Cast, domain.Cast> {
  @override
  domain.Cast convertToDomain(data.Cast inputType) {
    return domain.Cast(
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
