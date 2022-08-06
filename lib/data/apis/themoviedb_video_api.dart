import '../models/video_by_movie_response.dart';
import 'base_themoviedb_api.dart';

abstract class TheMovieDbVideoApi extends BaseTheMovieDbApi {
  Future<VideoByMovieResponse?> getVideoByMovie(int movieId);
}
