import 'youtube_video.dart';

class VideoByMovieResponse {
  int id;
  List<TheMovieDBYoutubeVideo> results;

  VideoByMovieResponse({this.id, this.results});

  VideoByMovieResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['results'] != null) {
      results = new List<TheMovieDBYoutubeVideo>();
      json['results'].forEach((v) {
        results.add(new TheMovieDBYoutubeVideo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'VideoByMovieResponse{id: $id, results: $results}';
  }
}
