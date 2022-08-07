import 'package:moviedb/domain/models/trending_media.dart';

abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailTrendingLoading extends MovieDetailState {}

class MovieDetailTrendingLoaded extends MovieDetailState {
  List<TrendingMedia> trendingMovies;
  MovieDetailTrendingLoaded(this.trendingMovies);
}
