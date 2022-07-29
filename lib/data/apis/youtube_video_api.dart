import 'package:sprintf/sprintf.dart';

import '../../utils/logger/logger.dart';
import '../constants.dart';
import '../models/youtube_video_response.dart';
import 'base_api.dart';

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
