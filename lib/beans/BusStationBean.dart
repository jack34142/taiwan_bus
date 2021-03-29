/// StationPosition : {"PositionLat":25.030203,"PositionLon":121.300541,"GeoHash":"wsqq2k87e"}
/// Stops : [{"StopUID":"THB303171","StopID":"303171","StopName":{"Zh_tw":"經國轉運站","En":"Jingguo Bus Station"},"RouteUID":"THB1662","RouteID":"1662","RouteName":{"Zh_tw":"1662","En":"1662"}},{"StopUID":"THB303171","StopID":"303171","StopName":{"Zh_tw":"經國轉運站","En":"Jingguo Bus Station"},"RouteUID":"THB1816","RouteID":"1816","RouteName":{"Zh_tw":"1816","En":"1816"}}]
/// UpdateTime : "2021-03-05T04:12:54+08:00"
/// VersionID : 814

class BusStationBean {
  StationPosition _stationPosition;
  List<Stops> _stops;
  String _updateTime;
  int _versionID;

  StationPosition get stationPosition => _stationPosition;
  List<Stops> get stops => _stops;
  String get updateTime => _updateTime;
  int get versionID => _versionID;

  BusStationBean({
      StationPosition stationPosition, 
      List<Stops> stops, 
      String updateTime, 
      int versionID}){
    _stationPosition = stationPosition;
    _stops = stops;
    _updateTime = updateTime;
    _versionID = versionID;
}

  BusStationBean.fromJson(dynamic json) {
    _stationPosition = json["StationPosition"] != null ? StationPosition.fromJson(json["StationPosition"]) : null;
    if (json["Stops"] != null) {
      _stops = [];
      json["Stops"].forEach((v) {
        _stops.add(Stops.fromJson(v));
      });
    }
    _updateTime = json["UpdateTime"];
    _versionID = json["VersionID"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_stationPosition != null) {
      map["StationPosition"] = _stationPosition.toJson();
    }
    if (_stops != null) {
      map["Stops"] = _stops.map((v) => v.toJson()).toList();
    }
    map["UpdateTime"] = _updateTime;
    map["VersionID"] = _versionID;
    return map;
  }

}

/// StopUID : "THB303171"
/// StopID : "303171"
/// StopName : {"Zh_tw":"經國轉運站","En":"Jingguo Bus Station"}
/// RouteUID : "THB1662"
/// RouteID : "1662"
/// RouteName : {"Zh_tw":"1662","En":"1662"}

class Stops {
  String _stopUID;
  String _stopID;
  StopName _stopName;
  String _routeUID;
  String _routeID;
  RouteName _routeName;

  String get stopUID => _stopUID;
  String get stopID => _stopID;
  StopName get stopName => _stopName;
  String get routeUID => _routeUID;
  String get routeID => _routeID;
  RouteName get routeName => _routeName;

  Stops({
      String stopUID, 
      String stopID, 
      StopName stopName, 
      String routeUID, 
      String routeID, 
      RouteName routeName}){
    _stopUID = stopUID;
    _stopID = stopID;
    _stopName = stopName;
    _routeUID = routeUID;
    _routeID = routeID;
    _routeName = routeName;
}

  Stops.fromJson(dynamic json) {
    _stopUID = json["StopUID"];
    _stopID = json["StopID"];
    _stopName = json["StopName"] != null ? StopName.fromJson(json["StopName"]) : null;
    _routeUID = json["RouteUID"];
    _routeID = json["RouteID"];
    _routeName = json["RouteName"] != null ? RouteName.fromJson(json["RouteName"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["StopUID"] = _stopUID;
    map["StopID"] = _stopID;
    if (_stopName != null) {
      map["StopName"] = _stopName.toJson();
    }
    map["RouteUID"] = _routeUID;
    map["RouteID"] = _routeID;
    if (_routeName != null) {
      map["RouteName"] = _routeName.toJson();
    }
    return map;
  }

}

/// Zh_tw : "1662"
/// En : "1662"

class RouteName {
  String _zhTw;
  String _en;

  String get zhTw => _zhTw;
  String get en => _en;

  RouteName({
      String zhTw, 
      String en}){
    _zhTw = zhTw;
    _en = en;
}

  RouteName.fromJson(dynamic json) {
    _zhTw = json["Zh_tw"];
    _en = json["En"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Zh_tw"] = _zhTw;
    map["En"] = _en;
    return map;
  }

}

/// Zh_tw : "經國轉運站"
/// En : "Jingguo Bus Station"

class StopName {
  String _zhTw;
  String _en;

  String get zhTw => _zhTw;
  String get en => _en;

  StopName({
      String zhTw, 
      String en}){
    _zhTw = zhTw;
    _en = en;
}

  StopName.fromJson(dynamic json) {
    _zhTw = json["Zh_tw"];
    _en = json["En"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Zh_tw"] = _zhTw;
    map["En"] = _en;
    return map;
  }

}

/// PositionLat : 25.030203
/// PositionLon : 121.300541
/// GeoHash : "wsqq2k87e"

class StationPosition {
  double _positionLat;
  double _positionLon;
  String _geoHash;

  double get positionLat => _positionLat;
  double get positionLon => _positionLon;
  String get geoHash => _geoHash;

  StationPosition({
      double positionLat, 
      double positionLon, 
      String geoHash}){
    _positionLat = positionLat;
    _positionLon = positionLon;
    _geoHash = geoHash;
}

  StationPosition.fromJson(dynamic json) {
    _positionLat = json["PositionLat"];
    _positionLon = json["PositionLon"];
    _geoHash = json["GeoHash"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["PositionLat"] = _positionLat;
    map["PositionLon"] = _positionLon;
    map["GeoHash"] = _geoHash;
    return map;
  }

}