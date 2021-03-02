class MyConfig {
  static const String BASE_URL = "https://ptx.transportdata.tw/";
  static const String BASE_API = BASE_URL + "MOTC/v2/Bus/Station/NearBy";

  static bool get isDebug {
    if (const bool.fromEnvironment('dart.vm.product')) {
      return false;
    } else {
      return true;
    }
  }
}
