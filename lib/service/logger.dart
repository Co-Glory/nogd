import 'package:logger/logger.dart';

final logger = Logger();

extension Log on Object {
  void logD([dynamic message]) => logger.d(toString(), message);
  void logE([dynamic message]) => logger.e(toString(), message);
  void logI([dynamic message]) => logger.i(toString(), message);
  void logW([dynamic message]) => logger.w(toString(), message);
  void logV([dynamic message]) => logger.v(toString(), message);
  void logWtf([dynamic message]) => logger.wtf(toString(), message);
}
