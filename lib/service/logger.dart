import 'package:logger/logger.dart';

final logger = Logger();

extension Log on Object {
  void logD([String? message]) => logger.d(toString(), message);
  void logE([String? message]) => logger.e(toString(),message);
  void logI([String? message]) => logger.i(toString(),message);
  void logW([String? message]) => logger.w(toString(),message);
  void logV([String? message]) => logger.v(toString(),message);
  void logWtf([String? message]) => logger.wtf(toString(),message);
}
