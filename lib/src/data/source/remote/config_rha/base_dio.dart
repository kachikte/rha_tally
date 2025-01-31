import 'package:dio/dio.dart';

import 'api_urls.dart';

class BaseDio {

  Dio dio = Dio();

  var options = BaseOptions(
      baseUrl: ApiUrls.url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
    connectTimeout: 1000 * 60,
    receiveTimeout: 1000 * 60
  );

  BaseDio() {
    dio = Dio(options);
  }
}