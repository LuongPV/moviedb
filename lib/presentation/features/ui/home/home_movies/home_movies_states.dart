import 'package:moviedb/domain/models/trending_media.dart';

abstract class HomeMoviesStates {}

class HomeMoviesInitial extends HomeMoviesStates {}

class HomeMoviesTrendingLoading extends HomeMoviesStates {}

class HomeMoviesTrendingLoaded extends HomeMoviesStates {
  List<TrendingMedia> trendingMovies;
  HomeMoviesTrendingLoaded(this.trendingMovies);
}
