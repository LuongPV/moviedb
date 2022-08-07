import '../../../../../domain/models/trending_media.dart';

abstract class HomeTvShowsState {}

class HomeTvShowsInitial extends HomeTvShowsState {}

class HomeTvShowsLoading extends HomeTvShowsState {}

class HomeTvShowsLoaded extends HomeTvShowsState {
  List<TrendingMedia> tvShows;
  HomeTvShowsLoaded(this.tvShows);
}
