import '../../../../../domain/models/cast.dart';
import '../../../../../domain/models/movie_detail.dart';
import '../../../../../domain/models/youtube_video_response.dart';

abstract class MovieDetailState {}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  MovieDetail movie;
  MovieDetailLoaded(this.movie);
}

class MovieDetailError extends MovieDetailState {}

class CastsLoaded extends MovieDetailState {
  List<Cast>? casts;
  CastsLoaded(this.casts);
}

class YoutubeVideosByMovieLoaded extends MovieDetailState {
  List<YoutubeVideo> youtubeVideos;
  YoutubeVideosByMovieLoaded(this.youtubeVideos);
}
