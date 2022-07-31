import '../cast/cast.dart';

class CastByTVShowResponse {
  int? id;
  List<Cast>? cast;

  CastByTVShowResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['cast'] != null) {
      json['cast'].forEach((v) {
        cast?.add(Cast.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['cast'] = cast?.map((v) => v.toJson()).toList();
    return data;
  }
}
