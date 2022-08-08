import 'package:moviedb/domain/models/cast_detail.dart';
import 'package:moviedb/domain/models/movie_general.dart';

abstract class CastDetailState {}

class CastDetailInitial extends CastDetailState {}

class CastDetailLoading extends CastDetailState {}

class CastDetailLoaded extends CastDetailState {
  CastDetail castDetail;

  CastDetailLoaded(this.castDetail);
}

class MovieByCastLoaded extends CastDetailState {
  List<MovieGeneral> movies;

  MovieByCastLoaded(this.movies);
}
