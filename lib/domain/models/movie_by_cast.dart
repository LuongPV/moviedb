import 'movie_general.dart';

class MovieByCastResponse {
  List<MovieGeneral> cast;
  int id;

  MovieByCastResponse({this.cast, this.id});

  MovieByCastResponse.fromJson(Map<String, dynamic> json) {
    if (json['cast'] != null) {
      cast = new List<MovieGeneral>();
      json['cast'].forEach((v) {
        cast.add(new MovieGeneral.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cast != null) {
      data['cast'] = this.cast.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}
