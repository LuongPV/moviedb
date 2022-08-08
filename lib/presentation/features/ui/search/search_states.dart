import '../../../../domain/models/movie_general.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchMoviesLoading extends SearchState {}

class SearchMoviesLoaded extends SearchState {
  List<MovieGeneral> movies;

  SearchMoviesLoaded(this.movies);
}
