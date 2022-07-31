import '../models/video_by_movie_response.dart';
import '../models/youtube_video_response.dart';

abstract class VideoRepository {
  Future<VideoByMovieResponse> getVideoByMovie(int movieId);

  Future<YoutubeVideoResponse> getVideoInfo(String videoId);
}
