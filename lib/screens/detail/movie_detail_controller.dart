import 'package:flutter/cupertino.dart';
import 'package:movie_db/data/models/cast.dart';
import 'package:movie_db/data/models/movie_detail.dart';
import 'package:movie_db/data/models/youtube_video.dart';
import 'package:movie_db/data/models/youtube_video_response.dart';
import 'package:movie_db/data/repositories/cast_repository.dart';
import 'package:movie_db/data/repositories/movie_repository.dart';
import 'package:movie_db/data/repositories/video_repository.dart';
import 'package:movie_db/screens/detail/movie_detail.dart';
import 'package:movie_db/utils/logger/logger.dart';

class MovieDetailController {
  final _videoRepository = VideoRepository();
  MovieDetail movie;
  List<Cast> casts;
  List<YoutubeVideo> trailerVideos = List();
  final _movieRepository = MovieRepository();
  final _castRepository = CastRepository();
  MovieDetailWidgetState state;
  BuildContext context;

  MovieDetailController(this.state, this.context);

  void getMovieDetail(int movieId) {
    _movieRepository.getMovieDetail(movieId).then((response) {
      state.updateUI(() {
        movie = response;
      });
    }).then((_) {
      _castRepository.getCastByMovie(movieId).then((response) {
        state.updateUI(() {
          casts = response.cast;
        });
      });
    }).then((_) {
      _videoRepository.getVideoByMovie(movieId).then((response) {
        response.results.forEach((result) {
          _videoRepository.getVideoInfo(result.key).then((response) {
            state.updateUI(() {
              trailerVideos.addAll(response.items.where((item) =>
                  item.snippet != null &&
                  item.snippet.thumbnails != null &&
                  item.snippet.thumbnails.getThumbnailInfo() != null));
            });
          });
        });
      });
    });
  }

}
