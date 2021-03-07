import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_db/data/apis/base_api.dart';
import 'package:movie_db/utils/logger/logger.dart';
import 'package:sprintf/sprintf.dart';

import '../constants.dart';

abstract class BaseTheMovieDbAPI extends BaseAPI {

  String appendImageUrl(String fileName) {
    if (fileName != null) {
      return fileName = sprintf(URL_MOVIE_IMAGE, [fileName]);
    }
    return null;
  }
}