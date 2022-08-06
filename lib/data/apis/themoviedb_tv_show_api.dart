import '../models/tv_show_detail.dart';
import 'base_themoviedb_api.dart';

abstract class TheMovieDbTVShowApi extends BaseTheMovieDbApi {
  Future<TVShowDetail?> getTVShowDetail(int movieId);
}
