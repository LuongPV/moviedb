
import 'package:http/http.dart' as http;
import 'package:movie_db/utils/logger/logger.dart';

abstract class BaseAPI {
  Future<String> executeGetRequest(String url) async {
    final encodedUrl = Uri.encodeFull(url);
    Logger.d('encodedUrl = $encodedUrl');
    final response = await http.get(encodedUrl);
    Logger.d('data = ${response.body}');
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

}