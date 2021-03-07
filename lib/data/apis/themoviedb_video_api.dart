import 'dart:io';

import 'package:movie_db/data/apis/base_themoviedb_api.dart';
import 'package:movie_db/data/models/video_by_movie_response.dart';
import 'package:movie_db/utils/logger/logger.dart';
import 'package:sprintf/sprintf.dart';

import '../constants.dart';

class TheMovieDbVideoAPI extends BaseTheMovieDbAPI {

  Future<VideoByMovieResponse> getVideoByMovie(int movieId) async {
    try {
      final url = sprintf(URL_VIDEO_BY_MOVIE, [movieId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = VideoByMovieResponse.fromJson(jsonMap);
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      throw e;
    }
  }

}