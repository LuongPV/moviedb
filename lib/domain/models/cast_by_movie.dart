import 'package:equatable/equatable.dart';

import 'cast.dart';

class CastByMovie extends Equatable {
  final int? id;
  final List<Cast>? cast;

  const CastByMovie(this.id, this.cast);

  @override
  List<Object?> get props => [id, cast];
}
