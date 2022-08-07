import '../../../../../domain/models/youtube_video_response.dart';
import '../../../../../domain/repositories/cast_repository.dart';
import '../../../../../domain/repositories/movie_repository.dart';
import '../../../../../domain/repositories/video_repository.dart';
import '../../../shared_blocs/base/base_bloc.dart';
import 'movie_detail_events.dart';
import 'movie_detail_states.dart';

class MovieDetailBloc extends BaseBloc<MovieDetailEvent, MovieDetailState> {
  final YoutubeVideoRepository _videoRepository;
  final MovieRepository _movieRepository;
  final CastRepository _castRepository;
  final int _movieId;

  MovieDetailBloc(this._videoRepository, this._movieRepository,
      this._castRepository, this._movieId)
      : super(MovieDetailInitial()) {
    processEvent<GetMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());
      try {
        final response = await _movieRepository.getMovieDetail(_movieId);
        emit(MovieDetailLoaded(response));
      } catch (e) {
        emit(MovieDetailError());
      }
    });
    processEvent<GetCasts>((event, emit) async {
      final response = await _castRepository.getCastByMovie(_movieId);
      emit(CastsLoaded(response));
    });
    processEvent<GetYoutubeVideosByMovie>((event, emit) async {
      final response =
          await _videoRepository.getMovieDbYoutubeVideoByMovie(_movieId);
      List<YoutubeVideo> youtubeVideos = [];
      for (var result in response) {
        final youtubeVideos = await _videoRepository.getYoutubeVideoInfo(
          result.key,
        );
        youtubeVideos.addAll(youtubeVideos.where(
          (item) =>
              item.snippet != null &&
              item.snippet?.thumbnails != null &&
              item.snippet?.thumbnails.getThumbnailInfo() != null,
        ));
      }
      emit(YoutubeVideosByMovieLoaded(youtubeVideos));
    });
    add(GetMovieDetail());
    add(GetCasts());
    add(GetYoutubeVideosByMovie());
  }
}
