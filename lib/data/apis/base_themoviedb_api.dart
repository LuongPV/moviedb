import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sprintf/sprintf.dart';

import '../constants.dart';
import 'base_api.dart';

abstract class BaseTheMovieDbAPI extends BaseAPI {

  String appendImageUrl(String fileName) {
    if (fileName != null) {
      return fileName = sprintf(URL_MOVIE_IMAGE, [fileName]);
    }
    return null;
  }
}