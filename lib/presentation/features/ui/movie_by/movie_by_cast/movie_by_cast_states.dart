import '../../../../../domain/models/movie_general.dart';

abstract class MovieByCastState {}

class MovieByCastInitial extends MovieByCastState {}

class MovieByCastLoaded extends MovieByCastState {
  List<MovieGeneral> movies;

  MovieByCastLoaded(this.movies);
}
