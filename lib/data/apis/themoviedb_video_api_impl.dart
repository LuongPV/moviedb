import 'dart:io';

import 'package:sprintf/sprintf.dart';

import '../../presentation/utils/logger/logger.dart';
import '../constants.dart';
import '../models/video_by_movie_response.dart';
import 'themoviedb_video_api.dart';

class TheMovieDbVideoApiImpl extends TheMovieDbVideoApi {
  @override
  Future<VideoByMovieResponse?> getVideoByMovie(int movieId) async {
    try {
      final url = sprintf(urlVideoByMovie, [movieId, Platform.localeName]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = VideoByMovieResponse.fromJson(jsonMap);
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      rethrow;
    }
  }
}
