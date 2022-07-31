import 'package:equatable/equatable.dart';

import 'cast.dart';

class CastByTVShow extends Equatable {
  final int? id;
  final List<Cast>? cast;

  const CastByTVShow(this.id, this.cast);

  @override
  List<Object?> get props => [id, cast];
}
