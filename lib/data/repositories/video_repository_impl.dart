import '../../domain/repositories/video_repository.dart';
import '../apis/themoviedb_video_api.dart';
import '../apis/youtube_video_api.dart';
import '../models/video_by_movie_response.dart';
import '../models/youtube_video_response.dart';

class VideoRepositoryImpl extends VideoRepository {
  final TheMovieDbVideoApi _theMovieDbAPI;
  final YoutubeVideoApi _youtubeVideoAPI;

  VideoRepositoryImpl(this._theMovieDbAPI, this._youtubeVideoAPI);

  @override
  Future<VideoByMovieResponse> getVideoByMovie(int movieId) {
    return _theMovieDbAPI.getVideoByMovie(movieId);
  }

  @override
  Future<YoutubeVideoResponse> getVideoInfo(String videoId) {
    return _youtubeVideoAPI.getVideoInfo(videoId);
  }
}
