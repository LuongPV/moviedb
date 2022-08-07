import 'package:moviedb/presentation/features/shared_blocs/base/base_bloc.dart';
import 'package:moviedb/presentation/features/ui/detail/movie/movie_detail_events.dart';
import 'package:moviedb/presentation/features/ui/detail/movie/movie_detail_states.dart';

import '../../data/models/cast.dart';
import '../../data/models/movie_detail.dart';
import '../../data/models/youtube_video_response.dart';
import '../../data/repositories/cast_repository.dart';
import '../../data/repositories/movie_repository.dart';
import '../../data/repositories/video_repository.dart';
import '../base/base_stateful_controller.dart';
import 'movie_detail.dart';

class MovieDetailBloc
    extends BaseBloc<MovieDetailEvent, MovieDetailState> {
  final _videoRepository = VideoRepository();
  final _movieRepository = MovieRepository();
  final _castRepository = CastRepository();
  MovieDetail movie;
  List<Cast> casts;
  List<YoutubeVideo> trailerVideos = List();

  MovieDetailController(state, context) : super(state, context);

  Future<void> getMovieDetail(int movieId) async {
    _movieRepository.getMovieDetail(movieId).then((response) async {
      movie = response;
      updateUI();
      return await _castRepository.getCastByMovie(movieId);
    }).then((response) {
      casts = response.cast;
      updateUI();
      return _videoRepository.getVideoByMovie(movieId);
    }).then((response) {
      response.results.forEach((result) {
        _videoRepository.getVideoInfo(result.key).then((response) {
          trailerVideos.addAll(response.items.where((item) =>
          item.snippet != null &&
              item.snippet.thumbnails != null &&
              item.snippet.thumbnails.getThumbnailInfo() != null)
          );
          updateUI();
        });
      });
    });
  }

  Future<void> refreshData(int movieId) => getMovieDetail(movieId);
}
