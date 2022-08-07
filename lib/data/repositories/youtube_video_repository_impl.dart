import '../../domain/models/youtube_video.dart';
import '../../domain/models/youtube_video_response.dart';
import '../../domain/repositories/video_repository.dart';
import '../apis/themoviedb_video_api.dart';
import '../apis/youtube_video_api.dart';

class YoutubeVideoRepositoryImpl extends YoutubeVideoRepository {
  final TheMovieDbVideoApi _theMovieDbAPI;
  final YoutubeVideoApi _youtubeVideoAPI;

  YoutubeVideoRepositoryImpl(this._theMovieDbAPI, this._youtubeVideoAPI);

  @override
  Future<List<TheMovieDBYoutubeVideo>> getMovieDbYoutubeVideoByMovie(int movieId) {
    return _theMovieDbAPI.getVideoByMovie(movieId);
  }

  @override
  Future<List<YoutubeVideo>> getYoutubeVideoInfo(String videoId) {
    return _youtubeVideoAPI.getVideoInfo(videoId);
  }
}
