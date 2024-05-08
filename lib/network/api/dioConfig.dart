import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';

import '../../utils/Constants.dart';

abstract class DioConfig {
  late Dio dio;

  DioConfig() {
    dio = Dio();
    dio.options.baseUrl = api;
    dio.interceptors.add(
      DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ),
    );
  }

  Options options() {
    return Options(
      sendTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        'content-Type': 'application/json',
      },
    );
  }
}
