// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:geeks_service/service/logger.dart';

class Failure implements Exception {
  const Failure([
    this.code = ResponseCode.DEFAULT,
    this.message = ResponseMessage.DEFAULT,
  ]);
  factory Failure.fromCode(dynamic error) {
    // '$error'.logV();
    switch (error.type) {
      case DioErrorType.connectTimeout:
        ResponseMessage.CONNECT_TIMEOUT.logE();
        return const Failure(
          ResponseCode.CONNECT_TIMEOUT,
          ResponseMessage.CONNECT_TIMEOUT,
        );
      case DioErrorType.sendTimeout:
        ResponseMessage.SEND_TIMEOUT.logE();
        return const Failure(
          ResponseCode.SEND_TIMEOUT,
          ResponseMessage.SEND_TIMEOUT,
        );
      case DioErrorType.receiveTimeout:
        ResponseMessage.RECEIVE_TIMEOUT.logE();
        return const Failure(
          ResponseCode.RECEIVE_TIMEOUT,
          ResponseMessage.RECEIVE_TIMEOUT,
        );
      case DioErrorType.response:
        if (error.response != null &&
            error.response?.statusCode != null &&
            error.response?.statusMessage != null) {
          error.response?.statusMessage.toString().logE();
          return Failure(
            error.response?.statusCode as int,
            error.response?.statusMessage as String,
          );
        } else {
          ResponseMessage.DEFAULT.logE();
          return const Failure();
        }
      case DioErrorType.cancel:
        ResponseMessage.CANCEL.logE();
        return const Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DioErrorType.other:
        if (error.error.toString().contains('SocketException')) {
          ResponseMessage.NO_INTERNET_CONNECTION.logE();
          return noInternetConnection();
        } else if (error.error.toString().contains(
              'Connection closed before full header was received',
            )) {
          ResponseMessage.RECEIVE_TIMEOUT.logE();
          return const Failure(
            ResponseCode.RECEIVE_TIMEOUT,
            ResponseMessage.RECEIVE_TIMEOUT,
          );
        }
    }
    ResponseMessage.DEFAULT.logE();
    return const Failure();
  }


  static Failure noInternetConnection() {
    return const Failure(
      ResponseCode.NO_INTERNET_CONNECTION,
      ResponseMessage.NO_INTERNET_CONNECTION,
    );
  }

  final String message;
  final int code;
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTHORIZED = 401; // failure, user is not authorized
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECEIVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String SUCCESS = 'success'; // success with data
  static const String NO_CONTENT =
      'success'; // success with no data (no content)
  static const String BAD_REQUEST =
      'Bad request, Try again later'; // failure, API rejected request
  static const String UNAUTHORIZED =
      'User is unauthorized, Try again later'; // failure, user is not authorized
  static const String FORBIDDEN =
      'Forbidden request, Try again later'; //  failure, API rejected request
  static const String INTERNAL_SERVER_ERROR =
      'Some thing went wrong, Try again later'; // failure, crash in server side
  static const String NOT_FOUND =
      'Some thing went wrong, Try again later'; // failure, crash in server side

  // local status code
  static const String CONNECT_TIMEOUT = 'Time out error, Try again later';
  static const String CANCEL = 'Request was cancelled, Try again later';
  static const String RECEIVE_TIMEOUT = 'Time out error, Try again later';
  static const String SEND_TIMEOUT = 'Time out error, Try again later';
  static const String CACHE_ERROR = 'Cache error, Try again later';
  static const String NO_INTERNET_CONNECTION =
      'Please check your internet connection';
  static const String DEFAULT = 'Some thing went wrong, Try again later';
}
