import 'package:movie_db/data/apis/themoviedb_video_api.dart';
import 'package:movie_db/data/apis/youtube_video_api.dart';
import 'package:movie_db/data/models/video_by_movie_response.dart';
import 'package:movie_db/data/models/youtube_video_response.dart';

class VideoRepository {
  final _theMovieDbAPI = TheMovieDbVideoAPI();
  final _youtubeVideoAPI = YoutubeVideoAPI();

  Future<VideoByMovieResponse> getVideoByMovie(int movieId) {
    return _theMovieDbAPI.getVideoByMovie(movieId);
  }

  Future<YoutubeVideoResponse> getVideoInfo(String videoId) {
    return _youtubeVideoAPI.getVideoInfo(videoId);
  }

}
