import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geeks_service/service/logger.dart';

class DioFactory {
  const DioFactory(this.dio);
  final Dio dio;
  ///
  ///@param {notRequiresTokenKey}
  ///this key is used to check if the request is not requires token
  Future<Dio> createDio(
      String baseUrlName, String notRequiresTokenKey, token) async {
    dio
      ..options.contentType = 'application/json; charset=UTF-8'
      ..options.baseUrl = baseUrlName
      ..options.connectTimeout = Duration.millisecondsPerMinute
      ..options.receiveTimeout = Duration.millisecondsPerMinute
      ..options.receiveDataWhenStatusError = true
      ..httpClientAdapter
      ..options.headers = <String, dynamic>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      };
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
        ),
      );
    }
    dio.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      if (options.headers.containsKey(notRequiresTokenKey)) {
        options.headers.remove(notRequiresTokenKey);
        options.headers;
        'withoute Token'.logD();
        return handler.next(options);
      } else {
        options.headers.addAll({'Authorization': 'Bearer $token'});
        'with --------- Token'.logD();
        return handler.next(options);
      }
    }));

    return dio;
  }
}
