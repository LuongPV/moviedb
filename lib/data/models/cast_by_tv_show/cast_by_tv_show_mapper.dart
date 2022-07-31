import 'package:moviedb/domain/models/cast_by_tv_show.dart';

import '../base_mapper.dart';
import '../cast/cast_mapper.dart';
import 'cast_by_tv_show.dart';

class CastByTvShowMapper extends BaseMapper<CastByTVShowResponse, CastByTVShow> {
  @override
  CastByTVShow convert(CastByTVShowResponse inputType) {
    return CastByTVShow(
      inputType.id,
      CastMapper().convertList(inputType.cast),
    );
  }
}
