// ignore_for_file: curly_braces_in_flow_control_structures, prefer_conditional_assignment, unnecessary_null_comparison, file_names

import 'package:dio/dio.dart';

class CustomDio {
  Dio _http = Dio();

  CustomDio() {
    if (_http == null) _http = Dio();
  }

  get client => _http;

  dispose() {
    _http.close();
  }
}
