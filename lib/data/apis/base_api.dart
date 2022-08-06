import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../presentation/utils/logger/logger.dart';

abstract class BaseApi {
  Future<ModelType?> executeGetRequest<ModelType>(
    String url,
    ModelType Function(Map<String, dynamic> jsonMap) modelCreator,
  ) async {
    final encodedUrl = Uri.encodeFull(url);
    Logger.d('encodedUrl = $encodedUrl');
    final response = await http.get(Uri.parse(encodedUrl));
    Logger.d('data = ${response.body}');
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = jsonDecode(response.body);
      return modelCreator(jsonMap);
    }
    return null;
  }
}
