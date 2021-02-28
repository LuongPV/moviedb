import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_db/utils/logger/logger.dart';
import 'package:sprintf/sprintf.dart';

import '../constants.dart';

abstract class BaseAPI {
  Future<ModelType> executeGetRequest<ModelType>(String url, ModelType modelCreator(Map jsonMap)) async {
    final encodedUrl = Uri.encodeFull(url);
    Logger.d('encodedUrl = $encodedUrl');
    final response = await http.get(encodedUrl);
    Logger.d('data = ${response.body}');
    if (response.statusCode == 200) {
      Map jsonMap = jsonDecode(response.body);
      return modelCreator(jsonMap);
    }
    return null;
  }

  String appendImageUrl(String fileName) {
    if (fileName != null) {
      return fileName = sprintf(URL_MOVIE_IMAGE, [fileName]);
    }
    return null;
  }
}