import 'package:moviedb/domain/models/trending_media.dart';

abstract class HomeMoviesState {}

class HomeMoviesInitial extends HomeMoviesState {}

class HomeMoviesTrendingLoading extends HomeMoviesState {}

class HomeMoviesTrendingLoaded extends HomeMoviesState {
  List<TrendingMedia> trendingMovies;
  HomeMoviesTrendingLoaded(this.trendingMovies);
}
