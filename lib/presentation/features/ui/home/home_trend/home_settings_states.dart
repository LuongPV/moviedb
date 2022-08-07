import '../../../../../domain/models/trending_media.dart';

abstract class HomeTrendingsStates {}

class HomeTrendingsInitial extends HomeTrendingsStates {}

class HomeTrendingsLoading extends HomeTrendingsStates {}

class HomeTrendingsLoaded extends HomeTrendingsStates {
  List<TrendingMedia> trendingMovies;
  HomeTrendingsLoaded(this.trendingMovies);
}
