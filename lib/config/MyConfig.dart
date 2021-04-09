import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

class MyConfig {
  static const String BASE_URL = "https://ptx.transportdata.tw/";
  static const String BASE_API = BASE_URL + "MOTC/v2/Bus/";

  static const double DEFAULT_ZOOM = 14.7;

  static bool get isDebug {
    if (const bool.fromEnvironment('dart.vm.product')) {
      return false;
    } else {
      return true;
    }
  }

  static Map<String, String> get ptxHeader {
    String appid = "3875e1cbcb1f411dadca8fd65ea5db67";
    String appkey = "ehzhfnorxJp7a1kcMnnHqNBEviU";

    var f = DateFormat('E, dd MMM yyyy HH:mm:ss');
    var date = f.format(DateTime.now().toUtc()) + " GMT";

    var key = utf8.encode(appkey);
    var bytes = utf8.encode("x-date: " + date);
    var hmacSha1 = new Hmac(sha1, key);
    var digest = hmacSha1.convert(bytes);
    String encoded = base64.encode(digest.bytes);

    return {
      "Authorization": 'hmac username="$appid", algorithm="hmac-sha1", headers="x-date", signature="$encoded"',
      "x-date": date,
      "Accept-Encoding": "gzip, deflate"
    };
  }
}
