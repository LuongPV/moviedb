import 'package:moviedb/domain/models/cast_by_tv_show.dart';

import '../data_to_domain_mapper.dart';
import '../cast/cast_mapper.dart';
import 'cast_by_tv_show.dart';

class CastByTvShowMapper with DataToDomainMapper<CastByTVShowResponse, CastByTVShow> {
  @override
  CastByTVShow convertToDomain(CastByTVShowResponse inputType) {
    return CastByTVShow(
      inputType.id,
      CastMapper().convertListToDomain(inputType.cast),
    );
  }
}
