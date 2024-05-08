import 'package:dio/dio.dart';
import 'dart:io';

import 'dioConfig.dart';


class Api extends DioConfig {
  Future<Response> getListData() {
    return dio.get(
      '/',
      options: options(),
    );
  }
}
