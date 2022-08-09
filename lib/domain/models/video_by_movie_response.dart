import 'youtube_video.dart';

class VideoByMovieResponse {
  int? id;
  List<TheMovieDBYoutubeVideo>? results;

  VideoByMovieResponse({this.id, this.results});

  @override
  String toString() {
    return 'VideoByMovieResponse{id: $id, results: $results}';
  }
}
