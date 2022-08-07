import '../../../../../domain/models/trending_media.dart';

abstract class HomeTrendingsState {}

class HomeTrendingsInitial extends HomeTrendingsState {}

class HomeTrendingsLoading extends HomeTrendingsState {}

class HomeTrendingsLoaded extends HomeTrendingsState {
  List<TrendingMedia> trendingMovies;
  HomeTrendingsLoaded(this.trendingMovies);
}
