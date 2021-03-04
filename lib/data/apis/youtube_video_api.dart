import 'package:movie_db/data/apis/base_api.dart';
import 'package:movie_db/data/models/youtube_video_response.dart';
import 'package:movie_db/utils/logger/logger.dart';
import 'package:sprintf/sprintf.dart';

import '../constants.dart';

class YoutubeVideoAPI extends BaseAPI {
  Future<YoutubeVideoResponse> getVideoInfo(String videoId) async {
    try {
      final url = sprintf(URL_YOUTUBE_VIDEO_INFO, [videoId]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = YoutubeVideoResponse.fromJson(jsonMap);
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      throw e;
    }
  }
}
