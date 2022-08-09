import '../../../../../domain/models/movie_general.dart';

abstract class MovieByGenreState {}

class MovieByGenreInitial extends MovieByGenreState {}

class MovieByGenreLoaded extends MovieByGenreState {
  List<MovieGeneral> movies;

  MovieByGenreLoaded(this.movies);
}