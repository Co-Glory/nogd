import 'package:logger/logger.dart';

Logger logger = Logger();

extension Log on Object {
  void logD() => logger.d(toString());
  void logE() => logger.e(toString());
  void logI() => logger.i(toString());
  void logW() => logger.w(toString());
  void logV() => logger.v(toString());
  void logWtf() => logger.wtf(toString());
}