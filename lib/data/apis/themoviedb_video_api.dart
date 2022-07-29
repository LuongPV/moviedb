import 'dart:io';

import 'package:sprintf/sprintf.dart';

import '../../utils/logger/logger.dart';
import '../constants.dart';
import '../models/video_by_movie_response.dart';
import 'base_themoviedb_api.dart';

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