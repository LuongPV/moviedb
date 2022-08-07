import '../models/youtube_video.dart';
import '../models/youtube_video_response.dart';

abstract class YoutubeVideoRepository {
  Future<List<TheMovieDBYoutubeVideo>> getMovieDbYoutubeVideoByMovie(int movieId);

  Future<List<YoutubeVideo>> getYoutubeVideoInfo(String videoId);
}
