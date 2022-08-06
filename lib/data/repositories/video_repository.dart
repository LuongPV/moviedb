import '../apis/themoviedb_video_api.dart';
import '../apis/youtube_video_api.dart';
import '../models/video_by_movie_response.dart';
import '../models/youtube_video_response.dart';

class VideoRepository {
  final _theMovieDbAPI = TheMovieDbVideoApi();
  final _youtubeVideoAPI = YoutubeVideoApi();

  Future<VideoByMovieResponse> getVideoByMovie(int movieId) {
    return _theMovieDbAPI.getVideoByMovie(movieId);
  }

  Future<YoutubeVideoResponse> getVideoInfo(String videoId) {
    return _youtubeVideoAPI.getVideoInfo(videoId);
  }

}
