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

  Future<void> getMovieDetail(int movieId) async {
    movie = await _movieRepository.getMovieDetail(movieId);
    state.updateUI(() {});
    casts = (await _castRepository.getCastByMovie(movieId)).cast;
    final videoByMovieResponse = await _videoRepository.getVideoByMovie(movieId);
    videoByMovieResponse.results.forEach((result) async {
      final videoInfoResponse = await _videoRepository.getVideoInfo(result.key);
      trailerVideos.addAll(videoInfoResponse.items.where((item) =>
          item.snippet != null &&
          item.snippet.thumbnails != null &&
          item.snippet.thumbnails.getThumbnailInfo() != null));
      state.updateUI(() {});
    });
    state.updateUI(() {});
  }

  Future<void> refreshData(int movieId) => getMovieDetail(movieId);

}
