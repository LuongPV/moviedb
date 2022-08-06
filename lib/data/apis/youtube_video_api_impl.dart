import 'package:sprintf/sprintf.dart';

import '../../presentation/utils/logger/logger.dart';
import '../constants.dart';
import '../models/youtube_video_response.dart';
import 'youtube_video_api.dart';

class YoutubeVideoApiImpl extends YoutubeVideoApi {
  @override
  Future<YoutubeVideoResponse?> getVideoInfo(String videoId) async {
    try {
      final url = sprintf(urlYoutubeVideoInfo, [videoId]);
      final responseModel = await executeGetRequest(url, (jsonMap) {
        var response = YoutubeVideoResponse.fromJson(jsonMap);
        return response;
      });
      return responseModel;
    } catch (e) {
      Logger.w('API Exception $e');
      rethrow;
    }
  }
}
