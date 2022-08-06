import '../models/youtube_video_response.dart';
import 'base_api.dart';

abstract class YoutubeVideoApi extends BaseApi {
  Future<YoutubeVideoResponse?> getVideoInfo(String videoId);
}
