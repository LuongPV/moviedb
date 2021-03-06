import 'package:movie_db/data/models/cast.dart';
import 'package:movie_db/data/models/movie_detail.dart';
import 'package:movie_db/data/models/youtube_video_response.dart';
import 'package:movie_db/data/repositories/cast_repository.dart';
import 'package:movie_db/data/repositories/movie_repository.dart';
import 'package:movie_db/data/repositories/video_repository.dart';
import 'package:movie_db/screens/base/base_stateful_controller.dart';
import 'package:movie_db/screens/detail/movie_detail.dart';

class MovieDetailController
    extends BaseStatefulController<MovieDetailWidgetState> {
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
