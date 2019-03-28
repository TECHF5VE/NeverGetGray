import 'package:dio/dio.dart';

class NetWorkUnit {
  static Future<Response> post(String baseUrl, String apiName, String port, Map<String, String> pathArgs, Map<String, String> args) {
    final apiPath = _buildPath(baseUrl, apiName, port, pathArgs);
    return Dio().post(apiPath, data: args);
  }

  static Future<Response> get(String baseUrl, String apiName, String port, Map<String, String> pathArgs) {
   final apiPath = _buildPath(baseUrl, apiName, port, pathArgs);
   return Dio().get(apiPath);
  }

  static String _buildPath(String baseUrl, String apiName, String port, Map<String, String> pathArgs) {
    final url = StringBuffer('$baseUrl/$apiName');
    if (pathArgs != null) {
      url.write('?');
      final keys = pathArgs.keys.toList();
      for (var i = 0; i < keys.length; i++) {
        url.write('${keys[i]}/${pathArgs[keys[i]]}');
        if (i != keys.length - 1) {
          url.write('&');
        }
      }
    }

    return url.toString();
  }
}