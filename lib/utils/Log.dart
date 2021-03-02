import 'package:logger/logger.dart';

class Log {
//  factory HttpUtils() => _getInstance();
  static Log _instance;

  var logger = new Logger();

  Log._();

  static void v(dynamic msg){
    if (_instance == null){
      _instance = new Log._();
    }
    _instance.logger.v(msg);
  }

  static void d(dynamic msg){
    if (_instance == null){
      _instance = new Log._();
    }
    _instance.logger.d(msg);
  }

  static void i(dynamic msg){
    if (_instance == null){
      _instance = new Log._();
    }
    _instance.logger.i(msg);
  }

  static void w(dynamic msg){
    if (_instance == null){
      _instance = new Log._();
    }
    _instance.logger.w(msg);
  }

  static void e(dynamic msg){
    if (_instance == null){
      _instance = new Log._();
    }
    _instance.logger.e(msg);
  }

  static void wtf(dynamic msg){
    if (_instance == null){
      _instance = new Log._();
    }
    _instance.logger.wtf(msg);
  }
}